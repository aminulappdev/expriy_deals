
import 'package:expriy_deals/app/modules/seller/controllers/all_shop_controller.dart';
import 'package:expriy_deals/app/modules/seller/views/seller_profile_screen.dart';
import 'package:expriy_deals/app/modules/seller/widgets/shope_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
            CustomAppBar(name: 'shops.app_bar_title'.tr), // Localized "Shops"
            heightBox10,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAFAFA),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        widthBox8,
                        GestureDetector(
                          onTap: () {
                            String query = searchController.text;
                            // allShopController.onSearchQueryChangedShops(query); // Uncomment when implemented
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
                              // allShopController.onSearchQueryChangedShops(value); // Uncomment when implemented
                            },
                            decoration: InputDecoration(
                              hintText: 'shops.app_bar_title'.tr, // Localized "Search shops"
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
                ),
              ],
            ),
            heightBox12,
            Expanded(
              child: Obx(() {
                if (allShopController.inProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else if (allShopController.allShopData?.isEmpty ?? true) {
                  return Center(
                    child: Text(
                      'shops.no_shops'.tr, // Localized "No shops found"
                      style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
                    ),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.zero,
                    controller: scrollController,
                    itemCount: allShopController.allShopData?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Get.to(() => SellerProfileScreen(
                                  sellerData: {
                                    'sellerId': allShopController.allShopData?[index].author?.id ?? '',
                                    'shopName': allShopController.allShopData?[index].name ?? 'shop.unknown_shop'.tr, // Localized "Unknown Shop"
                                    'shopLogo': allShopController.allShopData?[index].logo ??
                                        'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                                    'shopId': allShopController.allShopData?[index].id ?? '',
                                    'sellerName': allShopController.allShopData?[index].author?.name ?? 'shop.unknown_seller'.tr, // Localized "Unknown Seller"
                                    'location': allShopController.allShopData?[index].address ?? 'shop.unknown_location'.tr, // Localized "Unknown Location"
                                    'phone': allShopController.allShopData?[index].author?.phoneNumber ?? 'shop.no_phone'.tr, // Localized "N/A"
                                    'description': allShopController.allShopData?[index].description ?? 'shop.no_description'.tr, // Localized "No Description"
                                  },
                                ));
                          },
                          image: allShopController.allShopData?[index].logo ??
                              'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                          title: allShopController.allShopData?[index].name ?? 'shop.unknown_shop'.tr, // Localized "Unknown Shop"
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
