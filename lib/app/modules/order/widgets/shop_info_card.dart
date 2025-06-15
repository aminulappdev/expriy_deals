import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopInfoCard extends StatelessWidget {
  final String shopLogo;
  final String shopName;
  final String productImage;
  final String productName;
  final String productPrice;
  final String productQuantity;

  const ShopInfoCard({
    super.key,
    required this.shopLogo,
    required this.shopName,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(shopLogo),
                    radius: 20.r,
                  ),
                  widthBox10,
                  Text(
                    shopName,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              heightBox10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(productImage),
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
                        Container(
                          color: Colors.transparent,
                          width: 200.w,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            productName,
                            style: GoogleFonts.poppins(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        heightBox12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productPrice,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              productQuantity,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heightBox10,
                    Text(
                      'Price Details',
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PriceRow(
                      name: 'Price',
                      price: productPrice,
                      nameSize: 14,
                      priceSize: 14,
                    ),
                    // PriceRow(
                    //   name: 'Shipping fee', 
                    //   price: '10',
                    //   nameSize: 14,
                    //   priceSize: 14,
                    // ),
                    Container(
                      height: 1.h,
                      color: Colors.grey.shade300,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    PriceRow(
                      name: 'Total Price',
                      price: productPrice,
                      nameSize: 14,
                      priceSize: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
