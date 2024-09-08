import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({super.key});

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  // InAppWebViewController? _webViewController;
  final CookieManager _cookieManager = CookieManager.instance();

  final String loginUrl = "https://leetcode.com/accounts/login";

  @override
  void initState() {
    super.initState();
  }

  // Change to your login URL
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(loginUrl)),
        onLoadStart: (InAppWebViewController controller, WebUri? url) {},
        onLoadStop: (InAppWebViewController controller, WebUri? url) async {
          List<Cookie> cookies =
              await _cookieManager.getCookies(url: url as WebUri);
          try {
            final leetcodeSession = cookies
                .singleWhere((cookie) => cookie.name == "LEETCODE_SESSION");
            print("leetcodeSession = $leetcodeSession");
            if (!context.mounted) {
              return;
            }
            Navigator.pop(context, "LEETCODE_SESSION=${leetcodeSession.value.toString()}");
          } catch (e) {
            print("Error: $e");
          }
        },
      ),
    );
  }
}
