import 'package:expriy_deals/app/modules/category/controllers/all_category_controller.dart';
import 'package:expriy_deals/app/modules/home/views/home_screen.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCatogoryScreen extends StatefulWidget {
  const AllCatogoryScreen({super.key});

  @override
  State<AllCatogoryScreen> createState() => _AllCatogoryScreenState();
}

class _AllCatogoryScreenState extends State<AllCatogoryScreen> {
  final categoryController = Get.put(AllCategoryController());

  @override
  void initState() {
    super.initState();
    categoryController.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            heightBox24,
            CustomAppBar(name: 'All Catogory'),
            heightBox8,
            Obx(() {
              final categories = categoryController.categoryData;
              if (categories == null || categories.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                    child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CategoryCard(
                        image: '',
                        onTap: () {},
                        name: '',
                      ),
                    );
                  },
                ));
              }
            })
          ],
        ),
      ),
    );
  }
}
