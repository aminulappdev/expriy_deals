
import 'dart:async';
import 'package:expriy_deals/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
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

class OTPVerifyScreen extends StatefulWidget {
  final String token;
  const OTPVerifyScreen({super.key, required this.token});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
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

  void resendOTP() {
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
  }

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
              CustomAppBar(name: 'otp_verify.app_bar_title'.tr), // Localized "OTP Verification"
              heightBox16,
              AuthHeaderText(
                title: 'otp_verify.header_title'.tr, // Localized "Enter OTP"
                subtitle: 'otp_verify.header_subtitle'.tr, // Localized subtitle
                titleFontSize: 20,
                subtitleFontSize: 12,
                sizeBoxHeight: 200,
              ),
              heightBox20,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      controller: otpCtrl,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'otp_verify_forgot.error_message'.tr; // Localized "Enter a valid 6-digit OTP"
                        }
                        return null;
                      },
                      pinTheme: PinTheme(
                        selectedColor: Colors.black,
                        activeColor: Colors.orange,
                        borderWidth: 0.5,
                        shape: PinCodeFieldShape.circle,
                        borderRadius: BorderRadius.circular(100.r),
                        inactiveColor: const Color(0xffD9A48E),
                        fieldHeight: 50.h,
                        fieldWidth: 50.h,
                        activeFillColor: Colors.white,
                        inactiveFillColor: const Color(0xffD9A48E).withOpacity(0.1),
                        selectedFillColor: Colors.white,
                      ),
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
                              text: controller.inProgress ? '' : 'otp_verify.confirm_button'.tr, // Localized "Confirm"
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
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'otp_verify.did_not_receive'.tr, // Localized "Didn’t receive code? "
                                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16.sp),
                                ),
                                TextSpan(
                                  text: 'otp_verify.resend_code'.tr, // Localized "Resend code"
                                  style: GoogleFonts.poppins(color: Colors.orange, fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'otp_verify.resend_code'.tr, // Localized "Resend code"
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
              heightBox100,
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
        Get.to(() => const SignInScreen());
      } else if (mounted) {
        showSnackBarMessage(context, otpVerifyController.errorMessage ?? 'otp_verify.error_message'.tr, true); // Localized fallback error
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
