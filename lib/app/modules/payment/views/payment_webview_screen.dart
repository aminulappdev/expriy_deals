
import 'package:expriy_deals/app/modules/payment/controllers/confirmed_payment_controller.dart';
import 'package:expriy_deals/app/modules/payment/controllers/payment_url_controller.dart';
import 'package:expriy_deals/app/modules/payment/views/payment_success_screen.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  // ignore: unused_field
  late WebViewController _controller;
  final ConfirmedPaymentController confirmedPaymentController =
      ConfirmedPaymentController();
  final PaymentURLController paymentURLController = PaymentURLController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Payment"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.paymentData['link'],
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
// \0
            paymentURLController.paymentUrl(url);
            final bool isSuccess = await paymentURLController.paymentUrl(url);
            if (isSuccess) {
              await confirmPayment('${widget.paymentData['reference']}');
              Get.to(PaymentSuccessScreen());
              
            }
    
            // Call your payment result handler or anything you want here
            debugPrint('::::::::::::: if condition ::::::::::::::::');
          }
        },
      ),
    );
  }

  Future<void> confirmPayment(String reference) async {
    final bool isSuccess =
        await confirmedPaymentController.confirmPaymentfunction(reference);
    if (isSuccess) {
      if (mounted) {
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, confirmedPaymentController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(context,
            confirmedPaymentController.errorMessage ?? 'Ekhanei problem', true);
      }
    }
  }
}
