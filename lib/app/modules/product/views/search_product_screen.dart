import 'package:expriy_deals/app/modules/product/widgets/search_bar_widget.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox24,
            CustomAppBar(name: 'Search products'),
            heightBox12,
            CustomSearchBar(shouldBackButton: false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            heightBox12,
            Text(
              'Delivery options',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            heightBox8,
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 196, 195, 195)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Free delivery',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                widthBox8,
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.iconButtonThemeColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Stander delivery',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
             heightBox12,
            Text(
              'Price',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Min'
                    ),
                  ),
                ),
                widthBox10,
                SizedBox(
                  height: 40,
                  width: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Max'
                    ),
                  ),
                ),
              ],
            ),
            heightBox12,
            Text(
              'Top Brands',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            heightBox8,
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 196, 195, 195)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Free delivery',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                widthBox8,
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.iconButtonThemeColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Stander delivery',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            heightBox12,
            Text(
              'Top Stroes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            heightBox8,
            Row(
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 196, 195, 195)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Free delivery',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                widthBox8,
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.iconButtonThemeColor),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      'Stander delivery',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
