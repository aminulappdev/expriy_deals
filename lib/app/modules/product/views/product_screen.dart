import 'dart:async';
import 'package:expriy_deals/app/modules/product/controllers/Special_product_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/controllers/category_product_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/recommend_product_controller.dart';
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
  late final AllProductController allProductController;
  late final SpecialProductController specialProductController;
  late final CategoryProductController categoryProductController;
  late final RecommendProductController recommendProductController;
  String searchQuery = '';
  Timer? _debounce;

  dynamic get activeController {
    if (widget.categoryName == 'Special-offer') {
      return specialProductController;
    } else {
      return categoryProductController;
    }
  }

  @override
  void initState() {
    super.initState();
    allProductController = Get.put(AllProductController());
    specialProductController = Get.put(SpecialProductController());
    categoryProductController = Get.put(CategoryProductController());
    recommendProductController = Get.put(RecommendProductController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryName == 'Special-offer') {
        specialProductController.getSpecialProduct();
      } else {
        categoryProductController.getProductByCategory(categoryId: widget.categoryId);
      }
    });

    searchController.addListener(() {
      _onSearchChanged(searchController.text);
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = value.trim();
      });
    });
  }

  List<dynamic> _getFilteredProducts(List<dynamic> products) {
    if (searchQuery.isEmpty) {
      return products;
    }
    return products.where((product) {
      final title = product.name?.toLowerCase() ?? '';
      return title.contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
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
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        widthBox8,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Icon(
                            Icons.search_rounded,
                            size: 24.h,
                            color: AppColors.iconButtonThemeColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: 'search_products.search_hint'.tr, // Localized "Search products"
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              searchController.clear();
                              _onSearchChanged('');
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Icon(
                                Icons.clear,
                                size: 20.h,
                                color: AppColors.iconButtonThemeColor,
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
                final controller = activeController;
                if (controller.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.productData == null || controller.productData!.isEmpty) {
                  return Center(child: Text('search_products.no_products'.tr)); // Localized "No products found"
                }
                final filteredProducts = _getFilteredProducts(controller.productData!);
                if (filteredProducts.isEmpty && searchQuery.isNotEmpty) {
                  return Center(child: Text('search_products.no_matching_products'.tr)); // Localized "No matching products found"
                }
                return GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: ProductCard(
                        isShowDiscount: true,
                        image: product.images.isNotEmpty ? product.images[0].url ?? '' : '',
                        title: product.name ?? 'info.no_data_message'.tr, // Localized "No data available"
                        price: product.price?.toString() ?? '',
                        productId: product.id ?? '',
                        discount: product.discount.toString(),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}