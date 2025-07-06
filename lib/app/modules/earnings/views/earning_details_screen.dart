
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EarningDetailsScreen extends StatelessWidget {
  final String orderId;
  const EarningDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(name: 'earning_details.app_bar_title'.tr), // Localized "Earning Details"
                heightBox12,
                Row(
                  children: [
                    Container(
                      height: 86.h,
                      width: 122.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        image: const DecorationImage(
                          image: AssetImage(AssetsPath.headphone),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    widthBox8,
                    SizedBox(
                      width: 220.w,
                      height: 76.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'earning_details.full_name_label'.tr, // Localized "Full name : "
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                              Text(
                                'Md Aminul Islam', // Consider fetching dynamically
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'earning_details.email_label'.tr, // Localized "Email : "
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                              Text(
                                'aminul@gmail.com', // Consider fetching dynamically
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'earning_details.number_label'.tr, // Localized "Number : "
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                              Text(
                                '0197564512', // Consider fetching dynamically
                                style: GoogleFonts.poppins(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                heightBox30,
                Text(
                  'earning_details.price_details_label'.tr, // Localized "Price Details"
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                heightBox8,
                PriceRow(
                  name: 'earning_details.transaction_id_label'.tr, // Localized "Transaction ID : "
                  price: '10', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox10,
                PriceRow(
                  name: 'earning_details.account_holder_label'.tr, // Localized "A/C holder name:"
                  price: '50', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'earning_details.account_number_label'.tr, // Localized "A/C number:"
                  price: '10', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'earning_details.received_amount_label'.tr, // Localized "Received amount:"
                  price: '10', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'earning_details.deduct_percentage_label'.tr, // Localized "Detect Percentage:"
                  price: '10', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'earning_details.final_amount_label'.tr, // Localized "Final Amount:"
                  price: '10', // Consider fetching dynamically
                  nameSize: 14,
                  priceSize: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
