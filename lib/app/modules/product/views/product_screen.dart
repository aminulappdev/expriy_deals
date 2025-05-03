import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatefulWidget {
  final bool shouldBackButton;
  static const String routeName = '/product-screen';
  const ProductScreen({super.key, required this.shouldBackButton});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // @override
  // void initState() {
  //   super.initState();
  //   scrollController.addListener(_loadMoreData);
  // }

  // void _loadMoreData() {
  //   if (scrollController.position.extentAfter < 500 &&
  //       !allProcuctController.inProgress) {
  //     allProcuctController.fetchAllProducts(null); // Trigger fetch more data
  //   }
  // }

  // void _onSearch() {
  //   String query = searchController.text;
  //   allProcuctController.onSearchQueryChangedProducts(query); // Trigger search
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            CustomAppBar(name: 'Search products'),
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
                          onTap: () {},
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
                            onChanged: (_) {},
                            decoration: InputDecoration(
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
              child: SizedBox(
                  child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: ProductCard(),
                        );
                      },
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
