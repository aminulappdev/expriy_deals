import 'dart:async';
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
  final AllProductController allProductController =
      Get.put(AllProductController());
  String searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    print('Category ID: ${widget.categoryId}');
    // Defer getProduct call until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryName == 'Special-offer') {
        print('Special offer data asteche');
        allProductController.getProduct(specialOffer: true);
      }
      if (widget.categoryId == '') {
        allProductController.getProduct();
      } else {
        allProductController.getProduct(categoryId: widget.categoryId);
      }
    });

    // Listen to search input changes
    searchController.addListener(() {
      _onSearchChanged(searchController.text);
    });
  }

  // Debounce search input to improve performance
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        searchQuery = value.trim();
      });
    });
  }

  // Filter products based on search query
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
                      color: Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
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
                            decoration: const InputDecoration(
                              hintText: 'Search products',
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
                if (allProductController.inProgress == true) {
                  return const Center(child: CircularProgressIndicator());
                } else if (allProductController.productData == null ||
                    allProductController.productData!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                final filteredProducts =
                    _getFilteredProducts(allProductController.productData!);
                if (filteredProducts.isEmpty && searchQuery.isNotEmpty) {
                  return const Center(
                      child: Text('No matching products found'));
                }
                return GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                          image: product.images.isNotEmpty
                              ? product.images[0].url ?? ''
                              : '',
                          title: product.name ?? '',
                          price: product.price?.toString() ?? '',
                          productId: product.id ?? '',
                        ),
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
