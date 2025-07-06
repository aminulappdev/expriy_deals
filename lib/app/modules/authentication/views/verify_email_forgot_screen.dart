
import 'package:expriy_deals/app/modules/authentication/views/otp_forgot_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailScreenWithForgot extends StatelessWidget {
  final String token;
  const VerifyEmailScreenWithForgot({super.key, required this.token});

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
              CustomAppBar(name: 'verify_email_forgot.app_bar_title'.tr), // Localized "Check Email"
              heightBox100,
              CircleAvatar(
                backgroundColor: const Color(0xFFD9A48E).withOpacity(0.1),
                backgroundImage: const AssetImage(AssetsPath.emailLogo),
                radius: 36.r,
              ),
              heightBox16,
              AuthHeaderText(
                title: 'verify_email_forgot.header_title'.tr, // Localized "A letter has been sent."
                subtitle: 'verify_email_forgot.header_subtitle'.tr, // Localized subtitle
                titleFontSize: 20,
                subtitleFontSize: 12,
                sizeBoxHeight: 215,
              ),
              heightBox30,
              CustomElevatedButton(
                onPressed: () {
                  Get.to(() => OTPVerifyForgotScreen(token: token));
                },
                text: 'verify_email_forgot.confirm_button'.tr, // Localized "Read My Letter"
              ),
              heightBox8,
            ],
          ),
        ),
      ),
    );
  }
}
