import 'package:expriy_deals/app/modules/payment/controllers/payment_services.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderCard extends StatelessWidget {
  final String orderId;
  final String productName;
  final String status;
  final String price;
  final String quantity;
  final String imagePath;
  final VoidCallback mainBTNOntap;
  final dynamic
      productDetailsData; // Assuming product data is passed for navigation

  MyOrderCard({
    super.key,
    required this.productName,
    required this.status,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.mainBTNOntap,
    required this.productDetailsData,
    required Null Function() secondBTNOntap,
    required this.orderId,
  });

  final PaymentService paymentService = PaymentService();

  @override
  Widget build(BuildContext context) {
    final isPending = status.toLowerCase() == 'pending';
    final isDelivered = status.toLowerCase() == 'delivered';
    final showSecondButton = isPending || isDelivered;
    final secondButtonText = isPending ? 'make_payment'.tr : 'buy_now'.tr;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 12.w),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: imagePath.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(imagePath),
                                fit: BoxFit.fill,
                              )
                            : DecorationImage(
                                image: AssetImage(AssetsPath.headphone),
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    widthBox8,
                    SizedBox(
                      width: 230.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                color: Colors.transparent,
                                width: 130.w,
                                child: Text(
                                  productName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(fontSize: 15.sp),
                                ),
                              ),
                              Container(
                                height: 23.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black12),
                                ),
                                child: Center(
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          heightBox12,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$$price',
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                              Text(
                                'Qty: $quantity',
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightBox8,
                showSecondButton
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: $price',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.redAccent,
                            onTap: () {
                              if (isPending) {
                                paymentService.payment(context, orderId, price);
                              } else if (isDelivered) {
                                // Navigate to CheckOutScreen for delivered orders
                                Get.to(() => CheckOutScreen(
                                      productDetailsData: productDetailsData,
                                    ));
                              }
                            },
                            child: SizedBox(
                              width: 110.w,
                              height: 36.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.iconButtonThemeColor,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    secondButtonText,
                                    style: TextStyle(
                                      color: AppColors.iconButtonThemeColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: mainBTNOntap,
                            child: SizedBox(
                              width: 90.w,
                              height: 36.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.iconButtonThemeColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    'view_details'.tr,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: $price',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          InkWell(
                            onTap: mainBTNOntap,
                            child: SizedBox(
                              width: 120.w,
                              height: 36.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.iconButtonThemeColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
