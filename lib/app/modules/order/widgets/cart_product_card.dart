import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String brand;
  final String color;
  final String quantity;
  final String price;
  final VoidCallback deleteOntap;
  final VoidCallback buyOntap;
  const CartProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.brand,
    required this.color,
    required this.quantity,
    required this.price,
    required this.deleteOntap, required this.buyOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      width: 317.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffF9F9F9),
          // ignore: deprecated_member_use
          border: Border.all(color: Colors.black.withOpacity(0.05))),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // ignore: unnecessary_null_comparison
                  image: imagePath != null || imagePath != ''
                              ? DecorationImage(
                                  image: NetworkImage(imagePath),
                                  fit: BoxFit.fill)
                              : DecorationImage(
                                  image: AssetImage(AssetsPath.headphone),
                                  fit: BoxFit.fill)),
            ),
            widthBox4,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  heightBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        
                        width: 150.w,
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          'Brand: $brand',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        'Quantity: $quantity',
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  heightBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        'Price',
                        style: TextStyle(fontSize: 13),
                      ),
                      widthBox8,
                      Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        '\$$price',
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  heightBox8,
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                      onTap: deleteOntap,
                      child: Container(
                        height: 25.h,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: AppColors.iconButtonThemeColor),
                        ),
                        child: Center(
                            child: Text(
                          'delete'.tr,
                          style:
                              TextStyle(color: AppColors.iconButtonThemeColor),
                        )),
                      ),
                    ),
                    widthBox10,
                    InkWell(
                      onTap: buyOntap,
                      child: Container(
                        height: 25.h,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.iconButtonThemeColor),
                        child: Center(
                            child: Text(
                          'buy'.tr,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255)),
                        )),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
