import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper {
  static Widget createWebView({
    required String initialUrl,
    void Function(WebViewController)? onWebViewCreated,
    void Function(String)? onPageStarted,
    void Function(String)? onPageFinished,
    void Function(WebViewController, Uri)? onUrlChange,
    ValueChanged<int>? onProgress,
    Widget? loadingWidget,
  }) {
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.transparent)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: onProgress,
            onPageStarted: onPageStarted,
            onPageFinished: onPageFinished,
            onNavigationRequest: (NavigationRequest request) {
              if (onUrlChange != null) {
                onUrlChange(WebViewController(), Uri.parse(request.url));
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(initialUrl)),
    );
  }

  static Widget createLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView'),
      ),
      body: WebViewHelper.createWebView(
        initialUrl: url,
        onPageStarted: (String url) {
          print('Page started loading: $url');
        },
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
        onProgress: (int progress) {
          print('Loading progress: $progress%');
        },
        loadingWidget: WebViewHelper.createLoadingWidget(),
      ),
    );
  }
}
//Purpose: Provides integration with WebView for displaying web content within the app.
// Usage: Used to embed and manage web content within the app using WebView.
