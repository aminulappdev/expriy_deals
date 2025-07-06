import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerProductScreen extends StatefulWidget {
  final Map<String, dynamic> sellerData;
  const SellerProductScreen({
    super.key,
    required this.sellerData,
  });

  @override
  State<SellerProductScreen> createState() => _SellerProductScreenState();
}

class _SellerProductScreenState extends State<SellerProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final AllProductController allProductController =
      Get.put(AllProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allProductController.getProduct(authorID: widget.sellerData['sellerId']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    widthBox8,
                    Container(
                      height: 34.h,
                      width: 34.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.iconButtonThemeColor,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.search_rounded,
                          size: 24.h,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    widthBox8,
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'shops.app_bar_title'
                              .tr, // Localized "Search products"
                          hintStyle: GoogleFonts.poppins(color: Colors.grey),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightBox12,
              Obx(() => Text(
                    'seller_products.item_label'.trParams({
                      'count':
                          '${allProductController.productData?.length ?? 0}',
                    }), // Localized "Item ({count})"
                    style: GoogleFonts.poppins(
                        fontSize: 12.sp, fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
        heightBox10,
        Container(
          height: 800.h,
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom),
          child: Obx(() {
            if (allProductController.inProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (allProductController.productData?.isEmpty ?? true) {
              return Center(
                child: Text(
                  'seller_product.no_products'
                      .tr, // Localized "No products found"
                  style:
                      GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
                ),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.zero,
                controller: scrollController,
                itemCount: allProductController.productData?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: ProductCard(
                      isShowDiscount: true,
                      image: allProductController
                                  .productData?[index].images.isNotEmpty ==
                              true
                          ? allProductController
                              .productData![index].images[0].url
                          : '',
                      title: allProductController.productData?[index].name ??
                          'seller_product.unknown_product'
                              .tr, // Localized "Unknown Product"
                      price: allProductController.productData?[index].price
                              ?.toString() ??
                          '0',
                      productId:
                          allProductController.productData?[index].id ?? '',
                    ),
                  );
                },
              );
            }
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
