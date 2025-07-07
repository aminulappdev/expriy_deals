
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/profile/controllers/change_password_controller.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/reset-password-screen';
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final ChangePasswordController changePasswordController = Get.find<ChangePasswordController>();
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
              CustomAppBar(name: 'change_password.app_bar_title'.tr), // Localized "Change Password"
              heightBox16,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'change_password.current_password_hint'.tr, // Localized "Current password"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: oldPasswordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'add_product.validation.empty_field'.tr; // Localized "Enter current password"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
                        hintText: 'change_password.current_password_hint'.tr, // Localized "Current password"
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'change_password.new_password_hint'.tr, // Localized "New password"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: passwordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'change_password.validation.empty_password'.tr; // Localized "Enter new password"
                        }
                        if (value.length < 6) {
                          return 'change_password.validation.empty_password_must'.tr; // Localized "Password must be at least 6 characters"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
                        hintText: 'change_password.validation.empty_password'.tr, // Localized "New password"
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'change_password.confirm_password_hint'.tr, // Localized "Confirm password"
                      style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xff626262)),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: confirmPasswordCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'change_password.confirm_password_hint'.tr; // Localized "Enter confirm password"
                        }
                        if (value != passwordCtrl.text) {
                          return 'change_password.error_messages.passwords_do_not_match'.tr; // Localized "Passwords do not match"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
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
                        hintText: 'change_password.confirm_password_hint'.tr, // Localized "Confirm password"
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    heightBox24,
                    GetBuilder<ChangePasswordController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: controller.inProgress ? () {} : () => onTapToNextButton(),
                              text: controller.inProgress ? '' : 'change_password.change_password_button'.tr, // Localized "Change Password"
                            ),
                            if (controller.inProgress)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
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
      final bool isSuccess = await changePasswordController.changePassword(
        oldPasswordCtrl.text,
        passwordCtrl.text,
        confirmPasswordCtrl.text,
        StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'change_password.success_messages.password_changed'.tr); // Localized "Password changed successfully"
          Get.to(const MainButtonNavbarScreen());
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            changePasswordController.errorMessage ?? 'change_password.error_messages.change_failed'.tr, // Localized "Failed to change password"
            true,
          );
        }
      }
    }
  }

  void clearTextField() {
    oldPasswordCtrl.clear();
    passwordCtrl.clear();
    confirmPasswordCtrl.clear();
  }

  @override
  void dispose() {
    oldPasswordCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }
}
