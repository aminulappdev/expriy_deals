// ignore_for_file: avoid_print
import 'package:expriy_deals/app/modules/product/controllers/add_to_cart_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/controllers/product_details_controller.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_caresoul_slider.dart';
import 'package:expriy_deals/app/modules/seller/views/seller_profile_screen.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsController productDetailsController = Get.put(ProductDetailsController());
  final AddToCartController addToCartController = Get.put(AddToCartController());
  final AllProductController allProductController = Get.put(AllProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productDetailsController.productDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(
            child: Obx(() {
              if (productDetailsController.inProgress) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final data = productDetailsController.productDetailsData;
                final double updatePrice = double.parse(data?.price?.toString() ?? '0');
                final double discountValue = updatePrice * ((100 - (int.parse(data?.discount?.toString() ?? '0'))) / 100);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(name: 'product_details.app_bar_title'.tr), // Localized "Product Details"
                    heightBox12,
                    HomeCarouselSlider(
                      images: productDetailsController.productDetailsData?.images ?? [],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data?.name ?? 'info.no_data_message'.tr, // Localized "No data available"
                          style: GoogleFonts.poppins(fontSize: 20.sp),
                        ),
                        Text(
                          '\$${discountValue.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(fontSize: 16.h, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    heightBox8,
                    Text(
                      'product_details.section_title'.tr, // Localized "Product Details"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    heightBox4,
                    Html(data: data?.details ?? ''),
                    heightBox4,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            data?.author?.shop?.logo != null
                                ? CircleAvatar(
                                    radius: 18.r,
                                    backgroundImage: NetworkImage(data!.author!.shop!.logo!),
                                  )
                                : CircleAvatar(
                                    backgroundColor: AppColors.themeColor,
                                    radius: 18.r,
                                    child: Text(
                                      data?.author?.shop?.name?.isNotEmpty == true
                                          ? data!.author!.shop!.name!.substring(0, 1)
                                          : '',
                                      style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
                                    ),
                                  ),
                            widthBox4,
                            Text(
                              data?.author?.shop?.name ?? 'seller_about.store_name_label'.tr, // Localized "Store Name: "
                              style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        heightBox8,
                        InkWell(
                          onTap: () {
                            if (data?.author != null && data?.author!.shop != null) {
                              Get.to(() => SellerProfileScreen(
                                    sellerData: {
                                      'sellerId': data?.author!.id ?? '',
                                      'shopName': data?.author!.shop!.name ?? 'seller_about.store_name_label'.tr,
                                      'shopLogo': data?.author!.shop!.logo,
                                      'shopId': data?.author!.shop!.id ?? '',
                                      'sellerName': data?.author!.name ?? 'info.no_data_message'.tr,
                                      'location': data?.author!.shop?.address ?? 'info.no_data_message'.tr,
                                      'phone': data?.author!.phoneNumber ?? 'info.no_data_message'.tr,
                                      'description': data?.author!.shop!.description ?? 'info.no_data_message'.tr,
                                    },
                                  ));
                            } else {
                              showSnackBarMessage(
                                context,
                                'product_details.error_messages.seller_data_not_available'.tr, // Localized "Seller data not available"
                                true,
                              );
                            }
                          },
                          child: Container(
                            height: 32.h,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xff308960),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                                Text(
                                  'product_details.visit_store_button'.tr, // Localized "Visit Store"
                                  style: GoogleFonts.poppins(color: Colors.white),
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.white,size: 14,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightBox12,
                    Container(
                      height: 70.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: 150.w,
                              height: 40.h,
                              child: GestureDetector(
                                onTap: () {
                                  if (data?.id != null && data?.stock != null) {
                                    addToCartFunction(data!.id!, data.stock.toString());
                                  } else {
                                    showSnackBarMessage(
                                      context,
                                      'product_details.error_messages.product_data_not_available'.tr, // Localized "Product data not available"
                                      true,
                                    );
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.iconButtonThemeColor),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'product_details.add_to_cart_button'.tr, // Localized "Add to cart"
                                      style: GoogleFonts.poppins(color: AppColors.iconButtonThemeColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              width: 150.w,
                              height: 42.h,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  if (data != null) {
                                    Get.to(() => CheckOutScreen(productDetailsData: data));
                                  } else {
                                    showSnackBarMessage(
                                      context,
                                      'product_details.error_messages.product_data_not_available'.tr, // Localized "Product data not available"
                                      true,
                                    );
                                  }
                                },
                                text: 'product_details.buy_now_button'.tr, // Localized "Buy now"
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Future<void> addToCartFunction(String productId, String quantity) async {
    final bool isSuccess = await addToCartController.addToCart(productId, quantity);
    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(
          context,
          'product_details.success_messages.added_to_cart'.tr, // Localized "Successfully added to cart"
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          addToCartController.errorMessage ?? 'product_details.error_messages.failed_to_add_to_cart'.tr, // Localized "Failed to add to cart"
          true,
        );
      }
    }
  }
}