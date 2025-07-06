
import 'package:expriy_deals/app/modules/authentication/views/verify_email_forgot_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String email;
  final String token;
  const ForgotPasswordScreen({super.key, required this.email, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(name: 'forgot_password.app_bar_title'.tr), // Localized "Forgot Password"
              heightBox16,
              AuthHeaderText(
                title: 'forgot_password.header_title'.tr, // Localized "No worries!"
                subtitle: 'forgot_password.header_subtitle'.tr, // Localized subtitle
                titleFontSize: 15,
                subtitleFontSize: 12,
                sizeBoxHeight: 400,
              ),
              heightBox12,
              Text(
                'forgot_password.email_label'.tr, // Localized "Email Address"
                style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              heightBox12,
              Container(
                height: 70.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  border:  Border.all(color: Color(0xffDCDCDC)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 21.r,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(Icons.email_sharp, color: Colors.white),
                      ),
                      SizedBox(
                        width: 250.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'forgot_password.email_label'.tr, // Localized "Email:"
                              style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
                            ),
                            heightBox8,
                            Text(
                              email.isNotEmpty ? email : 'forgot_password.no_email'.tr, // Localized "No email"
                              style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => VerifyEmailScreenWithForgot(token: token));
                        },
                        child: CircleAvatar(
                          radius: 21.r,
                          backgroundColor: AppColors.iconButtonThemeColor,
                          child: const Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              heightBox12,
            ],
          ),
        ),
      ),
    );
  }
}
