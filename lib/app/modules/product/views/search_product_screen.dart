import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:async';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final AllProductController allProductController = Get.find<AllProductController>();
  final AllCategoryController allCategoryController = Get.find<AllCategoryController>();
  bool _showCategories = false; // State variable to toggle category visibility
  String? _selectedCategoryId; // Track selected category ID
  final TextEditingController searchCtrl = TextEditingController();
  String searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allCategoryController.getCategory();
      // Fetch all products initially
      allProductController.getProduct(categoryId: null);
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
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

  // Filter products based on search query (only return matching products)
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox24,
            CustomAppBar(name: 'Search products'),
            heightBox12,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Icon(
                            Icons.search_rounded,
                            size: 30.h,
                            color: AppColors.iconButtonThemeColor,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchCtrl,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              hintText: 'Search products',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        if (searchCtrl.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              searchCtrl.clear();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: _showCategories,
                  onChanged: (value) {
                    setState(() {
                      _showCategories = value ?? false;
                      if (!_showCategories) {
                        _selectedCategoryId = null; // Reset selected category
                        allProductController.getProduct(categoryId: null); // Fetch all products
                      }
                    });
                  },
                ),
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            heightBox12,
            // Conditionally show category section based on _showCategories
            if (_showCategories) ...[
              Text(
                'Category',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              heightBox8,
              SizedBox(
                height: 30.h,
                child: Obx(() {
                  if (allCategoryController.inProgress == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (allCategoryController.categoryData == null ||
                      allCategoryController.categoryData!.isEmpty) {
                    return const Center(child: Text('No categories found'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allCategoryController.categoryData!.length,
                      itemBuilder: (context, index) {
                        final category = allCategoryController.categoryData![index];
                        final isSelected = _selectedCategoryId == category.id;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategoryId = category.id; // Update selected category
                              });
                              allProductController.getProduct(categoryId: category.id);
                            },
                            child: Container(
                              height: 34.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: isSelected
                                    ? Colors.blue
                                    : AppColors.iconButtonThemeColor,
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(0, 3),
                                    ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                child: Center(
                                  child: Text(
                                    category.name ?? 'Category',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                          ),
                        ));
                      },
                    );
                  }
                }),
              ),
              heightBox12,
            ],
            Expanded(
              child: Obx(() {
                if (allProductController.inProgress == true) {
                  return const Center(child: CircularProgressIndicator());
                } else if (allProductController.productData == null ||
                    allProductController.productData!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }
                final filteredProducts = _getFilteredProducts(allProductController.productData!);
                if (filteredProducts.isEmpty && searchQuery.isNotEmpty) {
                  return Center(child: Text('No matching products found'));
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
                        title: product.name ?? 'Product',
                        price: product.price?.toString() ?? '0',
                        productId: product.id ?? '',
                      ),
                    );
                  },
                );
              }),
            ),
            heightBox12,
          ],
        ),
      ),
    );
  }
}