
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/authentication/views/verify_email_screen.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/agree_condition_widget.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/footer_section.dart';
import 'package:expriy_deals/app/modules/authentication/widgets/welcome_text.dart';
import 'package:expriy_deals/app/modules/onboarding/widgets/custom_scafold_background.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/image_picker.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final CreateUserController createUserController = Get.put(CreateUserController());
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  File? image;
  bool _obscureText = true;
  bool showButton = false;

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
              CustomAppBar(name: 'sign_up.app_bar_title'.tr), // Localized "Sign Up"
              heightBox16,
              Align(
                alignment: Alignment.center,
                child: WelcomeText(
                  title: 'sign_up.header_title'.tr, // Localized "Create New Account"
                  subtitle: 'sign_up.header_subtitle'.tr, // Localized "Please fill your detail information."
                ),
              ),
              heightBox50,
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sign_up.full_name_label'.tr, // Localized "Full Name"
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff626262),
                      ),
                    ),
                    heightBox8,
                    TextFormField(
                      controller: nameCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.name,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'sign_up.empty_name_error'.tr; // Localized "Enter name"
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'sign_up.full_name_hint'.tr, // Localized "Enter your full name"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'sign_up.number_label'.tr, // Localized "Number"
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff626262),
                      ),
                    ),
                    heightBox8,
                    TextFormField(
                      maxLength: 15,
                      controller: numberCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'sign_up.empty_number_error'.tr; // Localized "Enter number"
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'sign_up.number_hint'.tr, // Localized "Enter your number"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'sign_up.email_label'.tr, // Localized "Email"
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
                          return 'sign_up.empty_email_error'.tr; // Localized "Enter email"
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'sign_up.invalid_email_error'.tr; // Localized "Enter a valid email address"
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'sign_up.email_hint'.tr, // Localized "example@gmail.com"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    heightBox8,
                    Text(
                      'sign_up.password_label'.tr, // Localized "Password"
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
                          return 'sign_up.empty_password_error'.tr; // Localized "Enter password"
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
                            setState(() => _obscureText = !_obscureText);
                          },
                        ),
                        hintText: 'sign_up.password_hint'.tr, // Localized "***********"
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    AgreeConditionCheck(
                      onChanged: (value) {
                        setState(() => showButton = value);
                      },
                    ),
                    heightBox24,
                    Visibility(
                      visible: showButton,
                      replacement: Opacity(
                        opacity: 0.5,
                        child: CustomElevatedButton(
                          text: 'sign_up.verify_email_button'.tr, // Localized "Verify Email"
                          onPressed: () {},
                        ),
                      ),
                      child: GetBuilder<CreateUserController>(
                        builder: (controller) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomElevatedButton(
                                onPressed: controller.inProgress ? () {} : () => onTapToNextButton(),
                                text: controller.inProgress ? '' : 'sign_up.verify_email_button'.tr, // Localized "Verify Email"
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
                    ),
                    heightBox12,
                    AuthenticationFooterSection(
                      fTextName: 'sign_up.footer_first_text'.tr, // Localized "Already have an account? "
                      fTextColor: const Color(0xff33363F),
                      sTextName: 'sign_up.footer_second_text'.tr, // Localized "Log In"
                      sTextColor: const Color.fromARGB(255, 253, 107, 45),
                      ontap: () {
                        Get.to(() => const SignInScreen());
                      },
                    ),
                    heightBox100,
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
      final bool isSuccess = await createUserController.createUser(
        nameCtrl.text,
        numberCtrl.text,
        emailCtrl.text,
        passwordCtrl.text,
      );

      if (isSuccess && mounted) {
        showSnackBarMessage(context, 'sign_up.success_message'.tr); // Localized "New user created"
        Get.to(() => VerifyEmailScreen(token: createUserController.createUserData?.otpToken?.token ?? ''));
      } else if (mounted) {
        showSnackBarMessage(context, createUserController.errorMessage ?? 'sign_up.error_message'.tr, true); // Localized "Failed to create user"
      }
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    numberCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
