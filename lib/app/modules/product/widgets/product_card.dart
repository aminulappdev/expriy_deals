import 'package:expriy_deals/app/modules/product/views/product_datails_screen.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatefulWidget {
  final bool isShowDiscount;
  const ProductCard({
    super.key,
    this.isShowDiscount = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailScreen());
      },
      child: Card(
        elevation: 1,
        child: Container(
          height: 185.h,
          width: 156.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsPath.headphone),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(8)),
                  child: widget.isShowDiscount
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              height: 25,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.iconButtonThemeColor),
                              child: Center(
                                  child: Text(
                                '-10%',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color:
                                              AppColors.iconButtonThemeColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Icon(
                                      Icons.edit,
                                      color: AppColors.iconButtonThemeColor,
                                      size: 20,
                                    ),
                                  )),
                            ),
                          )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          'Hocco headphone',
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      heightBox5,
                      Text(
                        '\$50.0',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            color: AppColors.iconButtonThemeColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> getProductScreen() async {
  //   print('Hello');
  //   print(widget.productsModel.name);
  //   print(widget.productsModel.id);
  //   final bool isSuccess = await procuctDetailsController
  //       .getProductDetails(widget.productsModel.id!);

  //   if (isSuccess) {
  //     if (mounted) {
  //       Navigator.pushNamed(context, ProductDetailScreen.routeName,
  //           arguments: procuctDetailsController.productModel);

  //       // print('My token ---------------------------------------');
  //       // print(signUpController.token);
  //     } else {
  //       if (mounted) {
  //         showSnackBarMessage(
  //             context, procuctDetailsController.errorMessage!, true);
  //       }
  //     }
  //   }
  // }
}
