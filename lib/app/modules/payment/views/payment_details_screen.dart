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
  const PaymentDetailsScreen({
    super.key,
  });

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreen();
}

class _PaymentDetailsScreen extends State<PaymentDetailsScreen> {
  final PdfController pdfController = Get.put(PdfController());
  final ConfirmedPaymentController confirmedPaymentController =
      Get.find<ConfirmedPaymentController>();

  @override
  void initState() {
    super.initState();
    // Confirm payment on the page load
    print('Payment Details page e asche ........................');
    print(
        'Order ID Payment Details page er : ${StorageUtil.getData('order-id')}');
    confirmedPaymentController.confirmPaymentfunction(
        '${StorageUtil.getData('order-id')}'); // Change with your actual ID
    print('Details page data ....................');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ConfirmedPaymentController>(builder: (controller) {
        // Checking if the request is still in progress
        if (controller.inProgress) {
          return Center(child: CircularProgressIndicator());
        }

        // If an error occurred, display the error message
        if (controller.errorMessage != null) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        }

        DateTime? isoDate =
            controller.confirmedPaymentResponseModel?.data?.createdAt;
        String readableDate = isoDate != null
            ? DateFormat('MMMM dd, yyyy').format(isoDate)
            : 'Date not available';

        // Displaying the payment details once data is loaded
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            heightBox100,
                            PriceRow(
                              name: 'Date',
                              price: readableDate,
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'Transaction ID',
                              price:
                                  '${controller.confirmedPaymentResponseModel?.data?.trnId}',
                              nameSize: 14,
                              priceSize: 14,
                            ),
                           
                            heightBox8,
                            PriceRow(
                              name: 'Amount',
                              price:
                                  '${controller.confirmedPaymentResponseModel?.data?.price}',
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
                              name: 'Total',
                              price:
                                  '${controller.confirmedPaymentResponseModel?.data?.price}',
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
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            heightBox50,
            InkWell(
              onTap: () {
                pdfController.generateAndSavePDF(
                    readableDate,
                    '${controller.confirmedPaymentResponseModel?.data?.trnId}',
                    '${controller.confirmedPaymentResponseModel?.data?.price}',
                    '${controller.confirmedPaymentResponseModel?.data!.user?.name}');
              },
              child: Container(
                height: 48,
                width: 315,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.iconButtonThemeColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: AppColors.iconButtonThemeColor,
                    ),
                    widthBox8,
                    Text(
                      'Get pdf reciept',
                      style: TextStyle(color: AppColors.iconButtonThemeColor),
                    )
                  ],
                ),
              ),
            ),
            heightBox12,
            GestureDetector(
              onTap: () {
                Get.to(MainButtonNavbarScreen());
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
                    'Go to homepage',
                    style: TextStyle(color: AppColors.iconButtonThemeColor),
                  )
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
