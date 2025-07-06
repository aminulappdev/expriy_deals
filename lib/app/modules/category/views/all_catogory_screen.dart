
import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/category/widget/category_card.dart';
import 'package:expriy_deals/app/modules/product/views/product_screen.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  final categoryController = Get.put(AllCategoryController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          children: [
            heightBox24,
            CustomAppBar(name: 'all_category_screen.app_bar_title'.tr), // Localized "All Categories"
            heightBox8,
            Obx(() {
              if (categoryController.inProgress) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryController.categoryData?.isEmpty ?? true) {
                return Center(
                  child: Text(
                    'all_category_screen.no_categories_available'.tr, // Localized "No categories available"
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: categoryController.categoryData?.length ?? 0,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final category = categoryController.categoryData![index];
                      return CategoryCard(
                        image: category.banner ?? '',
                        onTap: () {
                          Get.to(() => ProductScreen(
                                shouldBackButton: true,
                                categoryId: category.id ?? '',
                                categoryName: category.name ?? 'category.unknown_category'.tr, // Localized "Unknown Category"
                              ));
                        },
                        name: category.name ?? 'category.unknown_category'.tr, // Localized "Unknown Category"
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
