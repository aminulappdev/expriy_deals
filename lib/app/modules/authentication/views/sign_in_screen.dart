import 'package:email_validator/email_validator.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/google_auth_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:expriy_deals/app/modules/authentication/views/forgot_password_screen.dart';
import 'package:expriy_deals/app/modules/authentication/views/sign_up_screen.dart';
import 'package:expriy_deals/app/modules/authentication/views/verify_email_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/continue_elevated_button.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/footer_section.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/forgot_password_row.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/liner_widget.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/welcome_text.dart';
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/onboarding/widgets/custom_scafold_background.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final SignInController signInController = Get.put(SignInController());
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  final ResendOTPController resendOTPController =
      Get.put(ResendOTPController());
  final GoogleAuthController googleAuthController =
      Get.put(GoogleAuthController());

  bool _obscureText = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldBackground(
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(
                  name: 'sign_in.app_bar_title'.tr), // Localized "Sign In"
              heightBox16,
              Align(
                alignment: Alignment.center,
                child: WelcomeText(
                  title: 'sign_in.header_title'
                      .tr, // Localized "Hi, Welcome back!"
                  subtitle: 'sign_in.header_subtitle'
                      .tr, // Localized "Sign in to continue exploring the best deals"
                ),
              ),
              heightBox50,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sign_in.email_label'.tr, // Localized "Email"
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff626262),
                      ),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: emailCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'sign_in.empty_email_error'
                              .tr; // Localized "Enter email"
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'sign_in.email_validation_invalid'
                              .tr; // Localized "Enter a valid email address"
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'sign_in.email_hint'
                            .tr, // Localized "example@gmail.com"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'sign_in.password_label'.tr, // Localized "Password"
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
                          return 'sign_in.password_validation_empty'
                              .tr; // Localized "Enter password"
                        }
                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () =>
                              setState(() => _obscureText = !_obscureText),
                        ),
                        hintText: 'sign_in.password_hint'
                            .tr, // Localized "***********"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ForgotPasswordRow(
                        title:
                            'sign_in.forgot_password', // Localized "Forgot Password?"
                        ontap: forgotPasswordBTN,
                      ),
                    ),
                    heightBox24,
                    GetBuilder<SignInController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: controller.inProgress
                                  ? () {}
                                  : () => onTapToNextButton(),
                              text: controller.inProgress
                                  ? ''
                                  : 'sign_in.app_bar_title'
                                      .tr, // Localized "Sign in"
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
                    Liner(),
                    ContinueElevatedButton(
                      name: 'sign_in.continue_with_google'
                          , // Localized "Continue with google"
                      logoPath: AssetsPath.googleLogoUp,
                      ontap: () => onTapGoogleSignIn(context),
                    ),
                    heightBox12,
                    AuthenticationFooterSection(
                      fTextName: 'sign_in.footer_first_text'
                          .tr, // Localized "Don’t have an account? "
                      fTextColor: const Color(0xff33363F),
                      sTextName: 'sign_in.footer_second_text'
                          .tr, // Localized "Sign up"
                      sTextColor: const Color.fromARGB(255, 253, 107, 45),
                      ontap: () {
                        Get.to(() => const SignUpScreen());
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

  Future<void> onTapGoogleSignIn(BuildContext context) async {
    final bool isSuccess = await googleAuthController.signInWithGoogle();
    if (isSuccess && context.mounted) {
      showSnackBarMessage(
          context,
          'sign_in.google_success_message'
              .tr); // Localized "Successfully logged in with Google"
    } else if (context.mounted) {
      final message = googleAuthController.errorMessage ??
          'sign_in.google_error_message'.tr; // Localized "Google login failed"
      if (message.contains('credentials')) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(
                'sign_in.account_issue_title'.tr), // Localized "Account Issue"
            content: Text('sign_in.account_issue_message'
                .tr), // Localized "This email is already registered with email-password. Please select another Google account."
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('sign_in.ok_button'.tr), // Localized "OK"
              ),
            ],
          ),
        );
        await onTapGoogleSignIn(context);
      } else {
        showSnackBarMessage(context, message, true);
      }
    }
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await signInController.signIn(emailCtrl.text, passwordCtrl.text);
      if (isSuccess && mounted) {
        showSnackBarMessage(
            context,
            'sign_in.success_message'
                .tr); // Localized "Login successfully done"
        Get.offAll(() => const MainButtonNavbarScreen());
      } else if (signInController.errorMessage?.contains('verified') ?? false) {
        final bool isResendSuccess =
            await resendOTPController.resendOTP(emailCtrl.text);
        if (isResendSuccess && mounted) {
          showSnackBarMessage(
              context,
              'sign_in.resend_otp_success'
                  .tr); // Localized "OTP resent successfully"
          Get.to(() =>
              VerifyEmailScreen(token: resendOTPController.otpToken ?? ''));
        } else if (mounted) {
          showSnackBarMessage(
              context,
              resendOTPController.errorMessage ?? 'sign_in.resend_otp_error'.tr,
              true); // Localized "Failed to resend OTP"
        }
      } else if (mounted) {
        showSnackBarMessage(
            context,
            signInController.errorMessage ?? 'sign_in.error_message'.tr,
            true); // Localized "Login failed"
      }
    }
  }

  Future<void> forgotPasswordBTN() async {
    if (emailCtrl.text.isEmpty) {
      showSnackBarMessage(context, 'sign_in.forgot_password_error_empty_email'.tr,
          true); // Localized "Fill-up your valid email"
    } else {
      final bool isSuccess =
          await forgotPasswordController.forgotPassword(emailCtrl.text);
      if (isSuccess && mounted) {
        showSnackBarMessage(
            context,
            'sign_in.forgot_password_success'
                .tr); // Localized "Password reset instructions sent"
        Get.to(() => ForgotPasswordScreen(
              email: emailCtrl.text,
              token: forgotPasswordController.accessToken ?? '',
            ));
      } else if (mounted) {
        showSnackBarMessage(
            context,
            forgotPasswordController.errorMessage ??
                'sign_in.forgot_password_error'.tr,
            true); // Localized "Error occurred"
      }
    }
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
