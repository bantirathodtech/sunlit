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

class WebViewRefreshTokenPage extends StatefulWidget {
  final int keyStatus;
  const WebViewRefreshTokenPage({super.key, required this.keyStatus});

  @override
  State<WebViewRefreshTokenPage> createState() =>
      _WebViewRefreshTokenPageState();
}

class _WebViewRefreshTokenPageState extends State<WebViewRefreshTokenPage> {
  late final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  var authUrl = "${plgAuthUrl}refresh-token";
  // var authUrl = "${plgAuthWebURL}refresh-token";
  int position = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setURL(0);
    callWebView();
  }

  /*Future<void> readCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      getCookieList(cookies);
    }
  }

  void getCookieList(String cookies) {
    printMessage("Cookies.....$cookies");
    if (cookies == '""' && !checkStatus(cookies)) {
      callWebLogin(context);
    }
  }*/

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
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            _onListCookies(context);
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
        backgroundColor: Colors.white,
        body: WebViewWidget(controller: webViewController),
      ),
    );
  }

  Future<void> _onListCookies(BuildContext context) async {
    final String cookies = await webViewController
        .runJavaScriptReturningResult('document.cookie') as String;
    if (context.mounted) {
      _getCookieList(cookies);
    }
  }

  void _getCookieList(String cookies) {
    if (cookies == '""' || !checkStatus(cookies)) {
      return;
    }
    printMessage("Cookies.....$cookies");
    readCookie(cookies);
  }

  void readCookie(String cookies) {
    List<String> temp = cookies.split(";");
    for (String ar1 in temp) {
      List<String> temp1 = ar1.split("=");
      if (temp1[0].contains("accessToken")) {
        setAccessToken((temp1[1]));
        break;
        /*position++;
        if(position==4){
          setAccessToken((temp1[1]));
          break;
        }*/
      }
    }
  }

  void setAccessToken(String token) {
    accessToken.accessToken = token;
    accessToken.loginTime = currentDate;
    accessToken.webAuth = true;
    // saveUserToken(accessToken);
    if (widget.keyStatus == 1) {
      backPressed(context, true);
    } else {
      callMainPage(context);
    }
  }
}
