
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool onBoardingRow;
  final bool showBackButton;
  final double imageHeight;
  final PageController pageController;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBoardingRow,
    required this.imageHeight,
    required this.showBackButton,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            heightBox20,
            Visibility(
              visible: !showBackButton,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.iconButtonThemeColor,
                      radius: 24.r,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const MainButtonNavbarScreen());
                    },
                    child: Text(
                      'onboarding_page.skip'.tr, // Localized "Skip"
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: AppColors.iconButtonThemeColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const SignInScreen());
                  },
                  child: Text(
                    'onboarding_page.skip'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: AppColors.iconButtonThemeColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            heightBox100,
            heightBox24,
            Column(
              children: [
                Image(
                  image: const AssetImage(AssetsPath.onboarding),
                  height: imageHeight,
                  width: imageHeight,
                  fit: BoxFit.fill,
                ),
                Text(
                  title.tr, // Localized title
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle.tr, // Localized subtitle
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
