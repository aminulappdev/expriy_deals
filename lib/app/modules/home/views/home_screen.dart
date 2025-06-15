// ignore_for_file: avoid_print

import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/category/views/all_catogory_screen.dart';
import 'package:expriy_deals/app/modules/category/widget/category_card.dart';
import 'package:expriy_deals/app/modules/home/widgets/product_item_shimmer.dart';
import 'package:expriy_deals/app/modules/home/widgets/see_all_section.dart';
import 'package:expriy_deals/app/modules/home/widgets/category_item_shimmer.dart';
import 'package:expriy_deals/app/modules/product/controllers/Special_product_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/controllers/category_product_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/recommend_product_controller.dart';
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
  final AllShopController allShopController = Get.put(AllShopController());
  final SpecialProductController specialProductController =
      Get.put(SpecialProductController());
  final CategoryProductController categoryProductController =
      Get.put(CategoryProductController());
  final RecommendProductController recommendProductController =
      Get.put(RecommendProductController());
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Uncomment if location is needed
      // requestLocationPermission();
      // getCurrentLocation();

      recommendProductController.getRecommenedProduct();
      specialProductController.getSpecialProduct();
      categoryController.getCategory();
      allProductController.getProduct();
      allShopController.myShops('-73.935242', '40.73061');
    });
  }

  Future<void> requestLocationPermission() async {
    final ph.PermissionStatus status = await ph.Permission.location.request();
    if (status.isGranted) {
      print('Location permission granted');
    } else if (status.isDenied) {
      print('Location permission denied');
    }
  }

  Future<void> getCurrentLocation() async {
    final loc.Location location = loc.Location();
    try {
      final loc.LocationData locationData = await location.getLocation();
      setState(() {
        latitude = locationData.latitude;
        longitude = locationData.longitude;
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
                        Get.to(const SearchProductScreen());
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
                    Get.to(const AllCatogoryScreen());
                  },
                ),
                heightBox8,
                Obx(() {
                  if (categoryController.inProgress) {
                    return const CategoryShimmerEffectWidget();
                  } else if (categoryController.categoryData?.isEmpty ?? true) {
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
                                      categoryId: categories[index].id ?? '',
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
                          'Special Offer',
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
                          categoryName: 'Special-offer',
                        ));
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
                  if (specialProductController.inProgress) {
                    return const ProductItemShimmerEffectWidget();
                  } else if (specialProductController.productData?.isEmpty ??
                      true) {
                    return SizedBox(
                      height: 180.h,
                      child: const Center(child: Text('No products available')),
                    );
                  } else {
                    final products = specialProductController.productData!;
                    print(
                        'Special data : ${specialProductController.productData}');
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ProductCard(
                              discount: product.discount?.toString() ?? '',
                              image: product.images.isNotEmpty == true
                                  ? product.images[0].url ?? ''
                                  : '',
                              price: product.price?.toString() ?? '',
                              title: product.name ?? '',
                              isShowDiscount: true,
                              productId: product.id ?? '',
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
                heightBox12,
                SeeAllSection(
                  title: 'Nearby Stores',
                  ontap: () {
                    Get.to(const ShopScreen(shouldBackButton: true));
                  },
                ),
                heightBox10,
                Obx(() {
                  if (allShopController.inProgress) {
                    return const ProductItemShimmerEffectWidget();
                  } else if (allShopController.allShopData?.isEmpty ?? true) {
                    return SizedBox(
                      height: 150.h,
                      child: const Center(child: Text('No shops available')),
                    );
                  } else {
                    final shops = allShopController.allShopData!;
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          final shop = shops[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ShopCard(
                              onTapF: () {
                                Get.to(SellerProfileScreen(
                                  sellerData: {
                                    'sellerId': shop.author?.id ?? '',
                                    'shopName': shop.name ?? 'Unknown Shop',
                                    'shopLogo': shop.logo ??
                                        'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                                    'shopId': shop.id ?? '',
                                    'sellerName':
                                        shop.author?.name ?? 'Unknown Seller',
                                    'location':
                                        shop.address ?? 'Unknown Location',
                                    'phone': shop.author?.phoneNumber ?? 'N/A',
                                    'description':
                                        shop.description ?? 'No Description',
                                  },
                                ));
                              },
                              image: shop.logo ??
                                  'https://fastly.picsum.photos/id/471/200/300.jpg?hmac=N_ZXTRU2OGQ7b_1b8Pz2X8e6Qyd84Q7xAqJ90bju2WU',
                              title: shop.name ?? 'Shop Name',
                              shopData: shop,
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
                    Get.to(const ProductScreen(
                      shouldBackButton: true,
                      categoryId: '',
                      categoryName: '',
                    ));
                  },
                ),
                heightBox10,
                Obx(() {
                  if (recommendProductController.inProgress) {
                    return const ProductItemShimmerEffectWidget();
                  } else if (recommendProductController.productData?.isEmpty ??
                      true) {
                    return SizedBox(
                      height: 180.h,
                      child: const Center(child: Text('No products available')),
                    );
                  } else {
                    final products = recommendProductController.productData!;
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length > 4 ? 4 : products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          if (product.totalSell == 0) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: ProductCard(
                                image: product.images.isNotEmpty == true
                                    ? product.images[0].url ?? ''
                                    : '',
                                price: product.price?.toString() ?? '',
                                title: product.name ?? '',
                                isShowDiscount: true,
                                productId: product.id ?? '',
                                discount: product.discount.toString(),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
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
