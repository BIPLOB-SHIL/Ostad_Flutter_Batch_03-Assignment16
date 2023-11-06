import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../ utility/show_snackbar.dart';
import '../../presentation/state_holders/cart_list_controller.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  late final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          print('entered');
          // if (url.endsWith("tran_type=success")) {
          //   navigateBack();
          // }
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          print(request);
          if (request.url.contains("tran_type=success")) {
            navigateBack();
          }

          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.paymentUrl));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }

  void navigateBack() {
    Navigator.pop(context);
    showSnackBar("Payment successful.\nYour order has been confirmed",
        context, Colors.green[500], true);
    Get.find<CartListController>().onClose();
  }
}
