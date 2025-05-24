import 'package:expriy_deals/app/modules/product/controllers/product_details_controller.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/modules/product/widgets/policy_custom_row.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_caresoul_slider.dart';
import 'package:expriy_deals/app/modules/product/widgets/see_more_button.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  bool _isExpandedProduct = false;
  bool _isExpandedPolicy = false;

  @override
  void initState() {
    print('Product ID: ${widget.productId}');
  
    productDetailsController.productDetails(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(child: Obx(() {
            if (productDetailsController.inProgress == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(name: 'Product Details'),
                  heightBox12,
                  HomeCarouselSlider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productDetailsController.productDetailsData?.name ??
                            'no name',
                        style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                        ),
                      ),
                      Text(
                        '\$89.99',
                        style: GoogleFonts.poppins(
                            fontSize: 16.h, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  heightBox8,
                  Text(
                    'Product Details',
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                  heightBox4,
                  AnimatedCrossFade(
                    firstChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name: UltraShield SPF 50+ Sunscreen'),
                        Text('Brand: SunGuard'),
                        Text('Type: Broad-Spectrum Protection'),
                        Text('SPF: 50+'),
                        Text('Formulation: Lotion'),
                        Text('Volume: 150 ml'),
                        Text('Price: \$18.99'),
                        Text(
                            'Key Ingredients: Avobenzone, Octinoxate, Titanium Dioxide'),
                        Text('Water Resistance: Up to 80 minutes'),
                        Text(
                            'Application: Apply generously on all exposed skin areas 15 minutes before sun exposure. Reapply every 2 hours or after swimming or sweating.'),
                        Text(
                            'Benefits: Helps prevent sunburn, premature skin aging, and skin cancer. Suitable for all skin types, including sensitive skin.'),
                      ],
                    ),
                    secondChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product Name: UltraShield SPF 50+ Sunscreen'),
                        Text('Brand: SunGuard'),
                        Text('Type: Broad-Spectrum Protection'),
                        Text('SPF: 50+'),
                        Text('Formulation: Lotion'),
                        Text('Volume: 150 ml'),
                      ],
                    ),
                    crossFadeState: _isExpandedProduct
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpandedProduct = !_isExpandedProduct;
                      });
                    },
                    child: SeeMoreButton(
                      isExpanded: _isExpandedProduct,
                    ),
                  ),
                  heightBox4,
                  AnimatedCrossFade(
                    firstChild: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PolicyCustomRow(
                            name: 'Warranty Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Return & Refund Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Replacement Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Return & Refund Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Replacement Policy',
                            routeName: '',
                          ),
                        ],
                      ),
                    ),
                    secondChild: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PolicyCustomRow(
                            name: 'Warranty Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Return & Refund Policy',
                            routeName: '',
                          ),
                          PolicyCustomRow(
                            name: 'Replacement Policy',
                            routeName: '',
                          ),
                        ],
                      ),
                    ),
                    crossFadeState: _isExpandedPolicy
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 300),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpandedPolicy = !_isExpandedPolicy;
                          });
                        },
                        child: SeeMoreButton(
                          isExpanded: _isExpandedPolicy,
                        )),
                  ),
                  Text(
                    'You might also like',
                    style: GoogleFonts.poppins(
                        fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  heightBox8,
                  SizedBox(
                    height: 180.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ProductCard(
                              productId: '',
                            ));
                      },
                    ),
                  ),
                  heightBox12,
                  Container(
                    height: 70.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SizedBox(
                            width: 159.w,
                            height: 42.h,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  Get.to(CheckOutScreen());
                                },
                                text: 'Buy now'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          })),
        ),
      ),
    );
  }
}
