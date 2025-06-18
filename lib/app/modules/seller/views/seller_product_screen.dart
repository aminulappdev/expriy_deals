import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allProductController.getProduct(authorID: widget.sellerData['sellerId']);
// \0
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('///////////////////////////////////');
    // print(allProductController.productData?.length);
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
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: AppColors.iconButtonThemeColor,
                      size: 24,
                    ))
              ],
            ),
          ),
        ),
        heightBox10,
        SizedBox(
            height: 800,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (allProductController.inProgress == true) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            allProductController.productData?.length ?? 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      .productData?[index].images[0].url ??
                                  '',
                              title: allProductController
                                      .productData?[index].name ??
                                  '',
                              price: allProductController
                                      .productData?[index].price
                                      .toString() ??
                                  '',
                              productId:
                                  allProductController.productData?[index].id ??
                                      '',
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            )),
      ],
    );
  }
}
