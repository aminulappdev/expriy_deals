// ignore_for_file: avoid_print

import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/category/views/all_catogory_screen.dart';
import 'package:expriy_deals/app/modules/category/widget/category_card.dart';
import 'package:expriy_deals/app/modules/home/widgets/product_item_shimmer.dart';
import 'package:expriy_deals/app/modules/home/widgets/see_all_section.dart';
import 'package:expriy_deals/app/modules/home/widgets/category_item_shimmer.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/views/product_screen.dart';
import 'package:expriy_deals/app/modules/product/views/search_product_screen.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/modules/profile/controllers/profile_controller.dart';
import 'package:expriy_deals/app/modules/seller/controllers/all_shop_controller.dart';
import 'package:expriy_deals/app/modules/seller/views/seller_profile_screen.dart';
import 'package:expriy_deals/app/modules/seller/views/shop_screen.dart';
import 'package:expriy_deals/app/modules/seller/widgets/shope_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as ph;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categoryController = Get.put(AllCategoryController());
  final AllProductController allProductController =
      Get.put(AllProductController());
  final AllShopController allShopController = Get.find<AllShopController>();

  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // requestLocationPermission();
      // getCurrentLocation();

      categoryController.getCategory();
      allProductController.getProduct();
      allShopController.myShops('-73.935242', '40.73061');
    });
  }

  Future<void> requestLocationPermission() async {
    final ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      // Permission granted; you can now retrieve the location.
    } else if (status.isDenied) {
      print('Location_permission_denied');
    }
  }

  Future<void> getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      final loc.LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude!;
        longitude = locationData.longitude!;
        print('Location is $latitude and $longitude');
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final controller = Get.find<ProfileController>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return controller.inProgress
                          ? const CircularProgressIndicator()
                          : CircleAvatar(
                              radius: 21.r,
                              backgroundImage:
                                  controller.profileData?.profile != null
                                      ? NetworkImage(
                                          controller.profileData!.profile!)
                                      : const AssetImage(AssetsPath.appleLogo),
                            );
                    }),
                    GestureDetector(
                      onTap: () {
                        Get.to(SearchProductScreen());
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
                  ],
                ),
                heightBox16,
                heightBox16,
                SeeAllSection(
                  title: 'Categories',
                  ontap: () {
                    Get.to(AllCatogoryScreen());
                  },
                ),
                heightBox8,
                // Reactive widget for categories
                Obx(() {
                  if (categoryController.inProgress == true) {
                    return CategoryShimmerEffectWidget();
                  } else if (categoryController.categoryData == null ||
                      categoryController.categoryData!.isEmpty) {
                    return const Center(child: Text('No categories available'));
                  } else {
                    final categories = categoryController.categoryData!;
                    return SizedBox(
                      height: 100.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CategoryCard(
                                  image: categories[index].banner ?? '',
                                  onTap: () {
                                    Get.to(ProductScreen(
                                      shouldBackButton: true,
                                      categoryId:
                                          categories[index].id ?? 'Empty',
                                      categoryName:
                                          categories[index].name ?? '',
                                    ));
                                  },
                                  name: categories[index].name ?? '',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Special offer',
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            color: AppColors.iconButtonThemeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        widthBox4,
                        Icon(
                          Icons.flash_on_outlined,
                          color: AppColors.iconButtonThemeColor,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ProductScreen(
                            shouldBackButton: true,
                            categoryId: '',
                            categoryName: 'Special-offer'));
                      },
                      child: Text(
                        'See all..',
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                  if (allProductController.inProgress == true) {
                    return ProductItemShimmerEffectWidget();
                  } else if (allProductController.productData == null ||
                      allProductController.productData!.isEmpty) {
                    return SizedBox(
                      height: 180.h,
                      child: Center(child: Text('No products available')),
                    );
                  } else {
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allProductController.productData!.length > 4
                            ? 4
                            : allProductController.productData!.length,
                        itemBuilder: (context, index) {
                          if (allProductController
                                  .productData![index].discount! >
                              60) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: ProductCard(
                                discount: allProductController
                                        .productData?[index].discount
                                        .toString() ??
                                    '',
                                image: allProductController
                                        .productData?[index].images[0].url ??
                                    '',
                                price: allProductController
                                        .productData?[index].price
                                        .toString() ??
                                    '',
                                title: allProductController
                                        .productData?[index].name ??
                                    '',
                                isShowDiscount: true,
                                productId: allProductController
                                        .productData?[index].id ??
                                    '',
                              ),
                            );
                          } else {
                            return SizedBox
                                .shrink(); // Return empty widget if no discount
                          }
                        },
                      ),
                    );
                  }
                }),
                heightBox12,
                SeeAllSection(
                  title: 'Nearby Stores',
                  ontap: () {
                    Get.to(ShopScreen(
                      shouldBackButton: true,
                    ));
                  },
                ),
                heightBox10,
                Obx(() {
                  if (allShopController.inProgress == true) {
                    return ProductItemShimmerEffectWidget();
                  } else if (allShopController.allShopData == null ||
                      allShopController.allShopData!.isEmpty) {
                    return SizedBox(
                      height: 150,
                      child: Center(child: Text('No shops available')),
                    );
                  } else {
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allShopController.allShopData?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ShopCard(
                              onTapF: () {
                                Get.to(SellerProfileScreen(
                                  sellerData: {
                                    'sellerId': allProductController
                                            .productData?[index].author?.id ??
                                        '',
                                    'shopName': allProductController
                                            .productData?[index]
                                            .author!
                                            .shop
                                            ?.name ??
                                        'Unknown Shop',
                                    'shopLogo': allProductController
                                            .productData?[index]
                                            .author
                                            ?.shop
                                            ?.logo ??
                                        'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                                    'shopId': allProductController
                                            .productData?[index]
                                            .author
                                            ?.shop
                                            ?.id ??
                                        '',
                                    'sellerName': allProductController
                                            .productData?[index].author?.name ??
                                        'Unknown Seller',
                                    'location': allProductController
                                            .productData?[index]
                                            .author
                                            ?.shop
                                            ?.address ??
                                        'Unknown Location',
                                    'phone': allProductController
                                            .productData?[index]
                                            .author
                                            ?.phoneNumber ??
                                        'N/A',
                                    'description': allProductController
                                            .productData?[index]
                                            .author
                                            ?.shop
                                            ?.description ??
                                        'No Description',
                                  },
                                ));
                              },
                              image: allShopController
                                      .allShopData?[index].logo ??
                                  'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                              title:
                                  allShopController.allShopData?[index].name ??
                                      'Shop Name',
                              shopData: allShopController.allShopData![index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
                heightBox12,
                SeeAllSection(
                  title: 'Recommended for You',
                  ontap: () {
                    Get.to(ProductScreen(
                        shouldBackButton: true,
                        categoryId: '',
                        categoryName: ''));
                  },
                ),
                heightBox10,
                Obx(() {
                  if (allProductController.inProgress == true) {
                    return ProductItemShimmerEffectWidget();
                  } else if (allProductController.productData == null ||
                      allProductController.productData!.isEmpty) {
                    return SizedBox(
                      height: 180.h,
                      child: Center(child: Text('No products available')),
                    );
                  } else {
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allProductController.productData!.length > 4
                            ? 4
                            : allProductController.productData!.length,
                        itemBuilder: (context, index) {
                          if (allProductController
                                  .productData![index].totalSell! ==
                              0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: ProductCard(
                                image: allProductController
                                        .productData?[index].images[0].url ??
                                    '',
                                price: allProductController
                                        .productData?[index].price
                                        .toString() ??
                                    '',
                                title: allProductController
                                        .productData?[index].name ??
                                    '',
                                isShowDiscount: true,
                                productId: allProductController
                                        .productData?[index].id ??
                                    '',
                              ),
                            );
                          } else {
                            return SizedBox
                                .shrink(); // Return empty widget if condition not met
                          }
                        },
                      ),
                    );
                  }
                }),
                heightBox20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
