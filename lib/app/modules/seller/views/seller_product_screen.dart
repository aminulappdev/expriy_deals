import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerProductScreen extends StatefulWidget {

  static const String routeName = '/product-screen';
  const SellerProductScreen({super.key,});

  @override
  State<SellerProductScreen> createState() => _SellerProductScreenState();
}

class _SellerProductScreenState extends State<SellerProductScreen> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item (10)'),
                IconButton(onPressed: () {
                  
                }, icon: Icon(Icons.search,color: AppColors.iconButtonThemeColor,size: 24,))
              ],
            ),
          ),
        ),
        heightBox10,
        SizedBox(
          height: 610,
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
      ],
    );
  }
}
