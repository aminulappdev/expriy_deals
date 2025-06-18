
import 'package:expriy_deals/app/modules/seller/views/seller_about_screen.dart';
import 'package:expriy_deals/app/modules/seller/views/seller_product_screen.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key, required this.sellerData});
  final Map<String, dynamic> sellerData;

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  int selectedPage = 0;


  @override
  void initState() {
// \0
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsPath.sellerBack),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            heightBox24,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.iconButtonThemeColor,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      heightBox20,
                      widget.sellerData['shopLogo'] == null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.themeColor,
                              child: Text(
                                widget.sellerData['sellerName']?.isNotEmpty == true
                                    ? widget.sellerData['sellerName'][0]
                                    : '',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.iconButtonThemeColor,
                              backgroundImage: NetworkImage(widget.sellerData['shopLogo']),
                            ),
                      heightBox10,
                      Text(
                        widget.sellerData['shopName'] ?? 'Unknown Shop',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.iconButtonThemeColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            heightBox30,
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 0;
                                });
                              },
                              child: Text(
                                'Products',
                                style: TextStyle(
                                  decorationColor: Colors.green,
                                  decoration: selectedPage == 0
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: selectedPage == 0 ? Colors.green : Colors.black,
                                ),
                              ),
                            ),
                            widthBox12,
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPage = 1;
                                });
                              },
                              child: Text(
                                'About',
                                style: TextStyle(
                                  decorationColor: Colors.green,
                                  decoration: selectedPage == 1
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: selectedPage == 1 ? Colors.green : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightBox8,
                      if (selectedPage == 0)
                        SellerProductScreen(sellerData: widget.sellerData)
                      else if (selectedPage == 1)
                        SellerAboutScreen(sellarData: widget.sellerData),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}