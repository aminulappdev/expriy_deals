import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final bool shouldBackButton;

  const ProductScreen({
    super.key,
    required this.shouldBackButton,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final AllProductController allProductController = Get.put(AllProductController());

  @override
  void initState() {
    super.initState();
    print('Category ID: ${widget.categoryId}');
    // Defer getProduct call until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryId == '') {
        allProductController.getProduct();
      } else {
        allProductController.getProduct(categoryId: widget.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            CustomAppBar(name: widget.categoryName),
            heightBox10,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        widthBox8,
                        GestureDetector(
                          onTap: () {
                            // Implement search functionality here
                            // String query = searchController.text;
                            // allProductController.onSearchQueryChangedProducts(query);
                          },
                          child: Container(
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
                        ),
                        widthBox8,
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            onChanged: (value) {
                              // Trigger search on text change
                              // allProductController.onSearchQueryChangedProducts(value);
                            },
                            decoration: const InputDecoration(
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
                ),
              ],
            ),
            heightBox12,
            Expanded(
              child: Obx(() {
                if (allProductController.inProgress == true) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
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
                          image: allProductController.productData?[index].images[0].url ?? '',
                          title: allProductController.productData?[index].name ?? '',
                          price: allProductController.productData?[index].price.toString() ?? '',
                          productId: allProductController.productData?[index].id ?? '',
                        ),
                      );
                    },
                  );
                }
              }), 
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}