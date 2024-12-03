import 'package:common/common_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class WebViewLoginPage extends StatefulWidget {
  const WebViewLoginPage({super.key});

  @override
  State<WebViewLoginPage> createState() => _WebViewLoginPageState();
}

class _WebViewLoginPageState extends State<WebViewLoginPage> {
  late final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  // var authUrl = "${plgAuthWebURL}sign-in";
  var authUrl = "${plgAuthUrl}sign-in";

  int position = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setURL(0);
    clearCookies(context);
    callWebView();
  }

  Future<void> clearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    printMessage(message);
  }

  callWebView() {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
            _onListCookies();
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
            code: ${error.errorCode}
            description: ${error.description}
            errorType: ${error.errorType}
            isForMainFrame: ${error.isForMainFrame}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          showSnackBar(message.message);
        },
      )
      ..loadRequest(Uri.parse(authUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: Scaffold(
        backgroundColor: HexColor("#F7F8FA"),
        //appBar: setAppBar(),
        body: WebViewWidget(controller: webViewController),
      ),
    );
  }

  setAppBar() {
    return AppBar(
      toolbarHeight: 60,
      //leading: backButton(context),
      elevation: 0,
      backgroundColor: HexColor(whiteColor),
      //iconTheme: IconThemeData(color: HexColor(blackColor)),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //destroyButton(context),
              //Icon(Icons.arrow_back_ios_new, color: HexColor(blackColor), size: 25,),
              appBarTitle("Login Auth"),
              /*IconButton(
                icon: const Icon(Icons.home, color: Colors.black),
                onPressed: () => callMainPage(context),
              ),*/
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _onListCookies() async {
    if (position == 0) {
      final String cookies = await webViewController
          .runJavaScriptReturningResult('document.cookie') as String;
      if (context.mounted) {
        _getCookieList(cookies);
      }
    }
  }

  void _getCookieList(String cookies) {
    if (cookies == '""' || !checkStatus(cookies)) {
      return;
    }
    printMessage("Cookies.....$cookies");
    readCookie(cookies);
  }

  late AccessToken accessToken = AccessToken(accessToken: "");
  void readCookie(String cookies) {
    List<String> temp = cookies.split(";");

    for (String ar1 in temp) {
      List<String> temp1 = ar1.split("=");

      accessToken.tokenType = "Bearer";

      if (temp1[0].contains("accessToken") && position == 0) {
        accessToken.accessToken = (temp1[1]);
      }

      if (temp1[0].contains("LastAuthUser") && position == 0) {
        accessToken.userEmail = (temp1[1]);
      }

      if (temp1[0].contains("username") && position == 0) {
        String userName = temp1[1];
        if (userName.contains("\"")) {
          userName = userName.replaceAll("\"", "");
        }
        accessToken.userName = userName;
      }

      if (temp1[0].contains("refreshToken") && position == 0) {
        accessToken.refreshToken = (temp1[1]);
      }

      if (temp1[0].contains("userId") && position == 0) {
        accessToken.userId = (temp1[1]);
      }
    }
    if (position == 0 && checkStatus(accessToken.accessToken.toString())) {
      position++;
      setAccessToken(accessToken);
    }
  }

  void setAccessToken(AccessToken accessToken) {
    accessToken.password = "";
    accessToken.webAuth = true;
    accessToken.loginTime = currentDate;
    // saveUserToken(accessToken);
    callMainPage(context);
  }
}
