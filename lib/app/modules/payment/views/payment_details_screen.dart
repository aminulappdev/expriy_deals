
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PaymentDetailsScreen extends StatefulWidget {

  const PaymentDetailsScreen({super.key});

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreen();
}

class _PaymentDetailsScreen extends State<PaymentDetailsScreen> {
 
  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                              price: '10',
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'Transaction ID',
                              price:
                                  '10',
                              nameSize: 14,
                              priceSize: 14,
                            ),
                            heightBox8,
                            PriceRow(
                              name: 'Amount',
                              price:
                                  '20',
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
                                  '200',
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
                          border: Border.all(
                              // ignore: deprecated_member_use
                              color: AppColors.iconButtonThemeColor.withOpacity(0.7),
                              width: 3),
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
        
      ),
    );
  }

  @override
  void dispose() {
   
    super.dispose();
  }
}
