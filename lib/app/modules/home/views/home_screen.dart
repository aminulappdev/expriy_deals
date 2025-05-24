import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/category/views/all_catogory_screen.dart';
import 'package:expriy_deals/app/modules/category/widget/category_card.dart';
import 'package:expriy_deals/app/modules/home/widgets/see_all_section.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_product_conrtoller.dart';
import 'package:expriy_deals/app/modules/product/views/product_screen.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Color> colorList = [
  Colors.deepPurple,
  Colors.redAccent,
  Colors.cyan,
  Colors.deepPurple,
  Colors.redAccent,
  Colors.cyan,
  Colors.deepPurple,
  Colors.redAccent,
  Colors.cyan,
];

class _HomeScreenState extends State<HomeScreen> {
  final categoryController = Get.put(AllCategoryController());
  final AllProductController allProductController =
      Get.put(AllProductController());

  @override
  void initState() {
    super.initState();
    categoryController.getCategory();
    allProductController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
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
                    CircleAvatar(
                      radius: 21.r,
                      backgroundImage: AssetImage(AssetsPath.headphone),
                    ),
                    Container(
                      height: 42.h,
                      width: 42.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffFB6000).withOpacity(0.10),
                      ),
                      child: const Icon(Icons.notifications),
                    )
                  ],
                ),
                heightBox16,
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: const Color(0xffFAFAFA),
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
                                onChanged: (_) {},
                                decoration: const InputDecoration(
                                  hintText: 'Search product',
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
                  final categories = categoryController.categoryData;
                  if (categories == null || categories.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (categoryController.inProgress == true) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
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
                                  image: '',
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
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ProductScreen(
                            shouldBackButton: true,
                            categoryId: '',
                            categoryName: 'Special offer'));
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
                    return CircularProgressIndicator();
                  } else {
                    return SizedBox(
                      height: 180.h,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            if (allProductController
                                    .productData![index].discount! >
                                0) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: ProductCard(
                                  image: allProductController
                                      .productData?[index].images[0].url,
                                  price: allProductController
                                          .productData?[index].price
                                          .toString() ??
                                      '',
                                  title: allProductController
                                      .productData?[index].name,
                                  isShowDiscount: true,
                                  productId: allProductController
                                          .productData?[index].id ??
                                      '',
                                ),
                              );
                            } else {
                              Center(
                                child: Text('No product avaiable'),
                              );
                            }
                            return Container();
                          }),
                    );
                  }
                }),
                heightBox12,
                SeeAllSection(
                  title: 'Nearby Stores',
                  ontap: () {
                    Get.to(ProductScreen(
                        shouldBackButton: true,
                        categoryId: '',
                        categoryName: ''));
                  },
                ),
                heightBox10,
                SizedBox(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: const ProductCard(
                          isShowDiscount: true,
                          productId: '',
                        ),
                      );
                    },
                  ),
                ),
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
                SizedBox(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: const ProductCard(
                          isShowDiscount: true,
                          productId: '',
                        ),
                      );
                    },
                  ),
                ),
                heightBox20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
