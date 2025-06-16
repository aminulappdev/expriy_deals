import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/category/widget/category_card.dart';
import 'package:expriy_deals/app/modules/product/views/product_screen.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    // Defer getCategory call to avoid setState during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.getCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            heightBox24,
            CustomAppBar(name: 'All Categories'), // Fixed typo in title
            heightBox8,
            Obx(() {
              if (categoryController.inProgress == true) {
                return const Center(child: CircularProgressIndicator());
              } else if (categoryController.categoryData!.isEmpty) {
                return const Center(child: Text('No categories available'));
              } else {
                return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: categoryController.categoryData?.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final category = categoryController.categoryData![index];
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CategoryCard(
                          image: category.banner ?? '',
                          onTap: () {
                            Get.to(ProductScreen(
                              shouldBackButton: true,
                              categoryId: category.id ?? 'Empty',
                              categoryName: category.name ?? '',
                            ));
                          },
                          name: category.name ?? 'No name',
                        ),
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