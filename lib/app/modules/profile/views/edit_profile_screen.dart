
// ignore_for_file: unused_field
import 'dart:io';
import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:expriy_deals/app/modules/profile/controllers/profile_controller.dart';
import 'package:expriy_deals/app/modules/profile/model/profile_model.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/image_picker.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  final ProfileData profileData;
  const EditProfile({super.key, required this.profileData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController editProfileController = Get.find<EditProfileController>();
  File? image;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController contactCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController stateCtrl = TextEditingController();
  final TextEditingController zipcodeCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.profileData.name ?? 'info.no_data_message'.tr; // Localized "No data available"
    emailCtrl.text = widget.profileData.email ?? 'info.no_data_message'.tr;
    contactCtrl.text = widget.profileData.phoneNumber ?? 'info.no_data_message'.tr;
    locationCtrl.text = widget.profileData.address ?? 'info.no_data_message'.tr;
    cityCtrl.text = widget.profileData.city ?? 'info.no_data_message'.tr;
    stateCtrl.text = widget.profileData.state ?? 'info.no_data_message'.tr;
    zipcodeCtrl.text = widget.profileData.zipCode ?? 'info.no_data_message'.tr;
    countryCtrl.text = widget.profileData.country ?? 'info.no_data_message'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                heightBox20,
                CustomAppBar(name: 'edit_profile.app_bar_title'.tr), // Localized "Update profile"
                heightBox12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          child: image != null
                              ? ClipOval(
                                  child: Image.file(
                                    image!,
                                    width: 80.h,
                                    height: 80.h,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                        widget.profileData.profile ??
                                            'https://fastly.picsum.photos/id/879/200/300.jpg?hmac=07llkorYxtpw0EwxaeqFKPC5woveWVLykQVnIOyiwd8',
                                      ),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              _imagePickerHelper.showAlertDialog(context, (File pickedImage) {
                                setState(() {
                                  image = pickedImage;
                                });
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: AppColors.iconButtonThemeColor,
                              radius: 16.r,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                heightBox12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'edit_profile.name_label'.tr, // Localized "Name"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: nameCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_name'.tr; // Localized "Enter name"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.email_label'.tr, // Localized "Email address"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      enabled: false,
                      controller: emailCtrl,
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.contact_label'.tr, // Localized "Contact Information"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: contactCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_contact'.tr; // Localized "Enter contact information"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.address_label'.tr, // Localized "Address"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: locationCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_address'.tr; // Localized "Enter address"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.city_label'.tr, // Localized "City"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: cityCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_city'.tr; // Localized "Enter city"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.state_label'.tr, // Localized "State"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: stateCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_state'.tr; // Localized "Enter state"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.zipcode_label'.tr, // Localized "Zipcode"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: zipcodeCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_zipcode'.tr; // Localized "Enter zipcode"
                        }
                        if (int.tryParse(value) == null) {
                          return 'edit_profile.error_messages.invalid_zipcode'.tr; // Localized "Enter a valid zipcode"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox12,
                    Text(
                      'edit_profile.country_label'.tr, // Localized "Country"
                      style: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                    heightBox4,
                    TextFormField(
                      controller: countryCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'edit_profile.error_messages.enter_country'.tr; // Localized "Enter country"
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                    heightBox20,
                    GetBuilder<EditProfileController>(
                      builder: (controller) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: controller.inProgress ? () {} : () => onTapToNextButton(),
                              text: controller.inProgress ? '' : 'edit_profile.update_button'.tr, // Localized "Update"
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await editProfileController.updateProfile(
        image,
        nameCtrl.text,
        emailCtrl.text,
        contactCtrl.text,
        locationCtrl.text,
        cityCtrl.text,
        stateCtrl.text,
        zipcodeCtrl.text,
        countryCtrl.text,
        StorageUtil.getData(StorageUtil.userAccessToken),
      );

      if (isSuccess) {
        if (mounted) {
          Get.find<ProfileController>().getProfileData();
          showSnackBarMessage(context, 'edit_profile.success_messages.profile_updated'.tr); // Localized "Profile updated"
          Get.to(const MainButtonNavbarScreen());
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
            context,
            editProfileController.errorMessage ?? 'edit_profile.error_messages.update_failed'.tr, // Localized "Failed to update profile"
            true,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    contactCtrl.dispose();
    locationCtrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();
    zipcodeCtrl.dispose();
    countryCtrl.dispose();
    super.dispose();
  }
}
