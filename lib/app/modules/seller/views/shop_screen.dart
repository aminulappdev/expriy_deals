import 'package:expriy_deals/app/modules/seller/controllers/all_shop_controller.dart';
import 'package:expriy_deals/app/modules/seller/views/seller_profile_screen.dart';
import 'package:expriy_deals/app/modules/seller/widgets/shope_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShopScreen extends StatefulWidget {
  final bool shouldBackButton;

  const ShopScreen({
    super.key,
    required this.shouldBackButton,
  });

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final AllShopController allShopController = Get.put(AllShopController());

  @override
  void initState() {
    super.initState();

    // Defer getProduct call until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      allShopController.myShops();
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
            CustomAppBar(
              name: 'Shops',
            ),
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
                if (allShopController.inProgress == true) {
                  return const Center(child: CircularProgressIndicator());
                } else if (allShopController.allShopData!.isEmpty ||
                    allShopController.allShopData == null) {
                  return Center(
                    child: Text(
                      'No shops found',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: allShopController.allShopData?.length ?? 0,
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
                        child: ShopCard(
                          onTapF: () {
                            Get.to(SellerProfileScreen(
                              sellerData: {
                                'sellerId': allShopController
                                        .allShopData?[index].author?.id ??
                                    '',
                                'shopName': allShopController
                                        .allShopData?[index].name ??
                                    'Unknown Shop',
                                'shopLogo': allShopController
                                        .allShopData?[index].logo ??
                                    'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                                'shopId':
                                    allShopController.allShopData?[index].id ??
                                        '',
                                'sellerName': allShopController
                                        .allShopData?[index].author?.name ??
                                    'Unknown Seller',
                                'location': allShopController
                                        .allShopData?[index].address ??
                                    'Unknown Location',
                                'phone': allShopController.allShopData?[index]
                                        .author?.phoneNumber ??
                                    'N/A',
                                'description': allShopController
                                        .allShopData?[index].description ??
                                    'No Description',
                              },
                            ));
                          },
                          image: allShopController.allShopData?[index].logo ??
                              'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                          title: allShopController.allShopData?[index].name ??
                              'Shop Name',
                          shopData: allShopController.allShopData![index],
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
