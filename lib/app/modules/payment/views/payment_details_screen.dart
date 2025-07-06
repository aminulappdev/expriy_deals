import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/modules/payment/controllers/confirmed_payment_controller.dart';
import 'package:expriy_deals/app/modules/payment/controllers/pdf_generator_controller.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/get_storage.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreen();
}

class _PaymentDetailsScreen extends State<PaymentDetailsScreen> {
  final PdfController pdfController = Get.put(PdfController());
  final ConfirmedPaymentController confirmedPaymentController = Get.find<ConfirmedPaymentController>();

  @override
  void initState() {
    super.initState();
    final orderId = StorageUtil.getData('order-id')?.toString() ?? '';
    if (orderId.isNotEmpty) {
      confirmedPaymentController.confirmPaymentfunction(orderId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConfirmedPaymentController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(child: Text('payment_details.error_message'.tr.replaceFirst('{error}', controller.errorMessage!))); // Localized "Error: {error}"
        }

        DateTime? isoDate = controller.confirmedPaymentResponseModel?.data?.createdAt;
        String readableDate = isoDate != null
            ? DateFormat('MMMM dd, yyyy').format(isoDate)
            : 'info.no_data_message'.tr; // Localized "No data available"

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightBox100,
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    elevation: 0.5,
                    child: Container(
                      height: 444.h,
                      width: 315.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            heightBox100,
                            PriceRow(
                              name: 'payment_details.date_label'.tr, // Localized "Date"
                              price: readableDate,
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'payment_details.transaction_id_label'.tr, // Localized "Transaction ID"
                              price: controller.confirmedPaymentResponseModel?.data?.trnId ?? 'info.no_data_message'.tr, // Localized "No data available"
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'payment_details.name_label'.tr, // Localized "Name"
                              price: controller.confirmedPaymentResponseModel?.data?.user?.name ?? 'info.no_data_message'.tr, // Localized "No data available"
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'payment_details.amount_label'.tr, // Localized "Amount"
                              price: controller.confirmedPaymentResponseModel?.data?.price?.toString() ?? 'info.no_data_message'.tr, // Localized "No data available"
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox30,
                            Container(
                              height: 1,
                              width: 315,
                              color: Colors.black,
                            ),
                            heightBox20,
                            PriceRow(
                              name: 'payment_details.total_label'.tr, // Localized "Total"
                              price: controller.confirmedPaymentResponseModel?.data?.price?.toString() ?? 'info.no_data_message'.tr, // Localized "No data available"
                              nameSize: 14,
                              priceSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 70.h,
                      width: 70.h,
                      decoration: BoxDecoration(
                        color: AppColors.iconButtonThemeColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            heightBox50,
            InkWell(
              onTap: () {
                pdfController.generateAndSavePDF(
                  readableDate,
                  controller.confirmedPaymentResponseModel?.data?.trnId ?? '',
                  controller.confirmedPaymentResponseModel?.data?.price?.toString() ?? '0',
                  controller.confirmedPaymentResponseModel?.data?.user?.name ?? '',
                );
              },
              child: Container(
                height: 48,
                width: 315,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.iconButtonThemeColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: AppColors.iconButtonThemeColor,
                    ),
                    widthBox8,
                    Text(
                      'payment_details.download_pdf_button'.tr, // Localized "Get PDF receipt"
                      style: TextStyle(color: AppColors.iconButtonThemeColor),
                    ),
                  ],
                ),
              ),
            ),
            heightBox12,
            GestureDetector(
              onTap: () {
                Get.to(() => const MainButtonNavbarScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.iconButtonThemeColor,
                  ),
                  widthBox8,
                  Text(
                    'payment_details.go_to_homepage'.tr, // Localized "Go to homepage"
                    style: TextStyle(color: AppColors.iconButtonThemeColor),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    box.remove('payment-reference-id');
    super.dispose();
  }
}