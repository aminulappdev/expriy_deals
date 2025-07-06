
import 'package:expriy_deals/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password-screen';
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());

  bool _obscureText = true;

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
              CustomAppBar(name: 'reset_password.app_bar_title'.tr), // Localized "Reset Password"
              heightBox16,
              AuthHeaderText(
                title: 'reset_password.header_title'.tr, // Localized "Let’s secure your space."
                subtitle: 'reset_password.header_subtitle'.tr, // Localized subtitle
                titleFontSize: 15,
                subtitleFontSize: 12,
                sizeBoxHeight: 300,
              ),
              heightBox12,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'reset_password.new_password_label'.tr, // Localized "Enter New Password"
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff626262),
                      ),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: passwordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'reset_password.empty_password_error'.tr; // Localized "Enter password"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: 'reset_password.password_hint'.tr, // Localized "***********"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox12,
                    Text(
                      'reset_password.confirm_password_label'.tr, // Localized "Confirm Password"
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff626262),
                      ),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: confirmPasswordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'reset_password.empty_password_error'.tr; // Localized "Enter password"
                        }
                        if (value != passwordCtrl.text) {
                          return 'reset_password.password_mismatch_error'.tr; // Localized "Passwords do not match"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: 'reset_password.password_hint'.tr, // Localized "***********"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox24,
                    GetBuilder<ResetPasswordController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: controller.inProgress ? () {} : () => onTapToNextButton(),
                              text: controller.inProgress ? '' : 'reset_password.update_button'.tr, // Localized "Update Password"
                            ),
                            if (controller.inProgress)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await resetPasswordController.resetPassword(
        passwordCtrl.text,
        confirmPasswordCtrl.text,
        StorageUtil.getData(StorageUtil.userAccessToken) ?? '',
      );

      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'reset_password.success_message'.tr); // Localized "Reset password successfully done"
        Get.to(() => const SignInScreen());
      } else if (mounted) {
        showSnackBarMessage(context, resetPasswordController.errorMessage ?? 'reset_password.error_message'.tr, true); // Localized fallback error
      }
    }
  }

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }
}
