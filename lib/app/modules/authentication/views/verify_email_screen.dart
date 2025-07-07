
import 'package:expriy_deals/app/modules/authentication/views/otp_screen.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String token;
  const VerifyEmailScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBox20,
              CustomAppBar(name: 'verify_email.app_bar_title'.tr), // Localized "Verify Email"
              heightBox100,
              CircleAvatar(
                backgroundColor: const Color(0xFFD9A48E).withOpacity(0.1),
                backgroundImage: const AssetImage(AssetsPath.emailLogo),
                radius: 36.r,
              ),
              heightBox16,
              Text(
                'verify_email.header_title'.tr, // Localized "Check Email"
                style: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w400),
              ),
              heightBox12,
              SizedBox(
                width: 210.w,
                child: Text(
                  'verify_email.header_subtitle'.tr, // Localized "Please check your email to verify your account."
                  style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              heightBox30,
              CustomElevatedButton(
                onPressed: () {
                  Get.to(() => OTPVerifyScreen(token: token));
                },
                text: 'verify_email.confirm_button'.tr, // Localized "Confirm Now"
              ),
              heightBox8,
            ],
          ),
        ),
      ),
    );
  }
}
