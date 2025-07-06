
import 'dart:math';
import 'package:davi/davi.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Data {
  Data({required this.stringValue, required this.intValue});
  final String stringValue;
  final int intValue;
}

class EarningScreen extends StatefulWidget {
  const EarningScreen({super.key});

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  late DaviModel<Data> _model;

  @override
  void initState() {
    super.initState();
    final random = Random();
    final rows = List.generate(
      20,
      (i) => Data(
        stringValue: random.nextInt(0xFFFFFF).toRadixString(16).toUpperCase(),
        intValue: random.nextInt(100),
      ),
    );
    _model = DaviModel<Data>(
      rows: rows,
      columns: [
        DaviColumn(
          name: 'earning.order_id_column'.tr, // Localized "Order ID"
          cellValue: (p) => p.data.stringValue,
        ),
        DaviColumn(
          name: 'earning.customer_column'.tr, // Localized "Customer"
          cellValue: (p) => p.data.intValue.toString(),
        ),
        DaviColumn(
          name: 'earning.product_name_column'.tr, // Localized "Product name"
          cellValue: (p) => p.data.intValue.toString(),
        ),
        DaviColumn(
          name: 'earning.quantity_column'.tr, // Localized "Quantity"
          cellValue: (p) => p.data.intValue.toString(),
        ),
        DaviColumn(
          name: 'earning.status_column'.tr, // Localized "Status"
          cellValue: (p) => p.data.intValue.toString(),
        ),
        DaviColumn(
          name: 'earning.amount_column'.tr, // Localized "Amount"
          cellValue: (p) => p.data.intValue.toString(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          children: [
            heightBox40,
            CustomAppBar(name: 'earning.app_bar_title'.tr), // Localized "Earnings"
            heightBox12,
            Container(
              height: 192.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.iconButtonThemeColor.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'earning.your_balance_label'.tr, // Localized "Your Balance"
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$1000', // Consider fetching dynamically or localizing
                      style: GoogleFonts.poppins(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    heightBox12,
                    SizedBox(
                      width: 240.w,
                      child: CustomElevatedButton(
                        onPressed: () {
                          // Implement withdraw functionality (e.g., navigate to withdraw screen)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('earning.withdraw_message'.tr), // Localized "Withdraw initiated"
                            ),
                          );
                        },
                        text: 'earning.withdraw_button'.tr, // Localized "Withdraw"
                      ),
                    ),
                  ],
                ),
              ),
            ),
            heightBox12,
            Expanded(child: Davi<Data>(_model)),
          ],
        ),
      ),
    );
  }
}
