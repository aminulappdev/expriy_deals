import 'package:expriy_deals/app/modules/home/widgets/see_all_section.dart';
import 'package:expriy_deals/app/modules/product/views/product_screen.dart';
import 'package:expriy_deals/app/modules/product/widgets/product_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                                decoration: InputDecoration(
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
                    Navigator.pushNamed(context, ProductScreen.routeName,
                        arguments: true);
                  },
                ),
                heightBox8,
                SizedBox(
                  height: 120.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                  color: colorList[index],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.headphones,
                                color: Colors.white,
                                size: 36,
                              ),
                            ),
                            heightBox4,
                            Center(
                                child: SizedBox(
                              width: 70.w,
                              child: Text(
                                'Fasion & Apperial',
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 250.w,
                        child: Row(
                          children: [
                            Text(
                              'Special offer',
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  color: AppColors.iconButtonThemeColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            widthBox4,
                            Icon(
                              Icons.flash_on_outlined,
                              color: AppColors.iconButtonThemeColor,
                            )
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductScreen.routeName,
                            arguments: true);
                      },
                      child: Text(
                        'See all..',
                        style: GoogleFonts.poppins(
                            fontSize: 12.sp, color: Colors.green),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 180.h,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ProductCard(
                          isShowDiscount: true,
                        ),
                      );
                    },
                  ),
                ),
                heightBox12,
                SeeAllSection(
                  title: 'Nearby Stores',
                  ontap: () {
                    Navigator.pushNamed(context, ProductScreen.routeName,
                        arguments: true);
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
                        child: ProductCard(
                          isShowDiscount: true,
                        ),
                      );
                    },
                  ),
                ),
                heightBox12,
                SeeAllSection(
                  title: 'Recommended for You',
                  ontap: () {
                    Navigator.pushNamed(context, ProductScreen.routeName,
                        arguments: true);
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
                        child: ProductCard(
                          isShowDiscount: true,
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
