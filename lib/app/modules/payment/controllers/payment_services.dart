// payment_service.dart
import 'package:expriy_deals/app/modules/payment/controllers/payment_controller.dart';
import 'package:expriy_deals/app/modules/payment/views/payment_webview_screen.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PaymentService {
  final PaymentController paymentController = PaymentController();

  Future<void> payment(
    BuildContext context,
    String orderId,
    dynamic price,
  ) async {
    final bool isSuccess = await paymentController.getPayment(orderId, price);

    Map<String, dynamic> paymentData = {
      'link': paymentController.paymentData?.data,
      'reference': orderId
    };

    if (isSuccess) {
      // Directly use context without mounted check
      showSnackBarMessage(context, 'Payment request done');
      StorageUtil.saveData('order-id', orderId);
      Get.to(PaymentWebviewScreen(paymentData: paymentData));
    } else {
      // Error handling
      showSnackBarMessage(context,
          paymentController.errorMessage ?? 'There was a problem', true);
    }
  }
}
