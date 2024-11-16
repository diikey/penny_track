import 'package:flutter/material.dart';
import 'package:penny_track/data/dto/accounts/auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthWebModal extends StatefulWidget {
  final Auth auth;
  const AuthWebModal({super.key, required this.auth});

  @override
  State<AuthWebModal> createState() => _AuthWebModalState();
}

class _AuthWebModalState extends State<AuthWebModal> {
  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    // webViewController
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setNavigationDelegate(NavigationDelegate(
    //     onNavigationRequest: (request) {
    //       if (request.url.startsWith(widget.auth.authorizationUrl.toString())) {
    //         return NavigationDecision.prevent;
    //       }
    //       return NavigationDecision.navigate;
    //     },
    //   ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
        controller: webViewController
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(NavigationDelegate(
            onNavigationRequest: (request) {
              if (request.url.startsWith(widget.auth.redirectUrl.toString())) {
                if (!Uri.parse(request.url)
                    .queryParameters
                    .containsKey("code")) {
                  Navigator.pop(context, "error getting auth code");
                  return NavigationDecision.prevent;
                }
                Navigator.pop(context, request.url);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ))
          ..loadRequest(widget.auth.authorizationUrl!));
  }
}
