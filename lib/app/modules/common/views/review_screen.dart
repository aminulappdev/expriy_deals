
import 'package:expriy_deals/app/modules/onboarding/widgets/custom_scafold_background.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBackground(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heightBox20,
            Image(
              image: const AssetImage(AssetsPath.review),
              fit: BoxFit.contain,
            ),
            heightBox12,
            Text(
              'review.title'.tr, // Localized "Your application is under review"
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.iconButtonThemeColor,
              ),
              textAlign: TextAlign.center,
            ),
            heightBox10,
            Text(
              'review.subtitle'.tr, // Localized "We will notify you as soon as your account has been approved"
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
