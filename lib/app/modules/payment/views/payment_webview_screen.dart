import 'package:expriy_deals/app/modules/payment/controllers/confirmed_payment_controller.dart';
import 'package:expriy_deals/app/modules/payment/controllers/payment_url_controller.dart';
import 'package:expriy_deals/app/modules/payment/views/payment_success_screen.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebviewScreen extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  const PaymentWebviewScreen({
    super.key,
    required this.paymentData,
  });

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late WebViewController _controller;
  final ConfirmedPaymentController confirmedPaymentController = Get.find<ConfirmedPaymentController>();
  final PaymentURLController paymentURLController = Get.find<PaymentURLController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('payment_webview.app_bar_title'.tr), // Localized "Payment"
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.paymentData['link'] ?? '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          debugPrint('Page start loading: $url');
        },
        onPageFinished: (String url) async {
          debugPrint('Page finished loading: $url');
          if (url.contains("confirm-payment")) {
            final bool isSuccess = await paymentURLController.paymentUrl(url);
            if (isSuccess) {
              await confirmPayment('${widget.paymentData['reference'] ?? ''}');
              Get.to(() => const PaymentSuccessScreen());
            } else {
              if (mounted) {
                showSnackBarMessage(
                  context,
                  paymentURLController.errorMessage ?? 'payment_webview.error_message'.tr, // Localized "An error occurred"
                  true,
                );
              }
            }
          }
        },
      ),
    );
  }

  Future<void> confirmPayment(String reference) async {
    if (reference.isEmpty) {
      if (mounted) {
        showSnackBarMessage(
          context,
          'payment_webview.error_message'.tr, // Localized "An error occurred"
          true,
        );
      }
      return;
    }
    final bool isSuccess = await confirmedPaymentController.confirmPaymentfunction(reference);
    if (!isSuccess && mounted) {
      showSnackBarMessage(
        context,
        confirmedPaymentController.errorMessage ?? 'payment_webview.error_message'.tr, // Localized "An error occurred"
        true,
      );
    }
  }
}