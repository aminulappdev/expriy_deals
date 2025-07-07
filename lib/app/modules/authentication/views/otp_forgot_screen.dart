
import 'dart:async';
import 'package:expriy_deals/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:expriy_deals/app/modules/authentication/views/reset_password_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/auth_header_text.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerifyForgotScreen extends StatefulWidget {
  final String token;
  const OTPVerifyForgotScreen({super.key, required this.token});

  @override
  State<OTPVerifyForgotScreen> createState() => _OTPVerifyForgotScreenState();
}

class _OTPVerifyForgotScreenState extends State<OTPVerifyForgotScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController otpCtrl = TextEditingController();
  final OtpVerifyController otpVerifyController = Get.put(OtpVerifyController());

  RxInt remainingTime = 60.obs;
  late Timer timer;
  RxBool enableResendCodeButton = false.obs;

  @override
  void initState() {
    super.initState();
    resendOTP();
  }

  void resendOTP() async {
    enableResendCodeButton.value = false;
    remainingTime.value = 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        remainingTime.value--;
        if (remainingTime.value == 0) {
          t.cancel();
          enableResendCodeButton.value = true;
        }
      },
    );

    // Assuming resendOTPController exists and email is passed or stored
    // final bool isSuccess = await resendOTPController.resendOTP(email);
    // if (isSuccess && mounted) {
    //   showSnackBarMessage(context, 'otp_verify_forgot.resend_success_message'.tr);
    // } else if (mounted) {
    //   showSnackBarMessage(context, resendOTPController.errorMessage ?? 'otp_verify_forgot.resend_error_message'.tr, true);
    // }
  }

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
              CustomAppBar(name: 'otp_verify_forgot.app_bar_title'.tr), // Localized "OTP Verification"
              heightBox16,
              AuthHeaderText(
                title: 'otp_verify_forgot.header_title'.tr, // Localized "Verify Your Identity"
                subtitle: 'otp_verify_forgot.header_subtitle'.tr, // Localized subtitle
                titleFontSize: 15,
                subtitleFontSize: 12,
                sizeBoxHeight: 350,
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      controller: otpCtrl,
                      length: 6,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'otp_verify_forgot.error_message'.tr; // Localized "Enter a valid 6-digit OTP"
                        }
                        return null;
                      },
                      pinTheme: PinTheme(
                        borderWidth: 0.2,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        inactiveColor: const Color.fromARGB(218, 222, 220, 220),
                        fieldHeight: 55.h,
                        fieldWidth: 55.h,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      appContext: context,
                    ),
                    heightBox8,
                    GetBuilder<OtpVerifyController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: controller.inProgress ? () {} : () => onTapToNextButton(),
                              text: controller.inProgress ? '' : 'otp_verify_forgot.confirm_button'.tr, // Localized "Confirm"
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
                    heightBox12,
                    Obx(
                      () => Visibility(
                        visible: !enableResendCodeButton.value,
                        replacement: GestureDetector(
                          onTap: resendOTP,
                          child: Text(
                            'otp_verify_forgot.resend_code'.tr, // Localized "Resend code"
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'otp_verify_forgot.resend_code'.tr, // Localized "Resend code"
                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp),
                              ),
                              TextSpan(
                                text: ' $remainingTime',
                                style: GoogleFonts.poppins(color: Colors.orange, fontSize: 16.sp),
                              ),
                              TextSpan(
                                text: 's'.tr, // Localized "s"
                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
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
      final bool isSuccess = await otpVerifyController.otyVerify(otpCtrl.text, widget.token);
      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'otp_verify.success_message'.tr); // Localized "Otp verification successfully done"
        Get.to(() => const ResetPasswordScreen());
      } else if (mounted) {
        showSnackBarMessage(context, otpVerifyController.errorMessage ?? 'otp_verify_forgot.error_message'.tr, true); // Localized fallback error
      }
    }
  }

  @override
  void dispose() {
    otpCtrl.dispose();
    timer.cancel();
    super.dispose();
  }
}
