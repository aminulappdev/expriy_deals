
// ignore_for_file: deprecated_member_use
import 'package:expriy_deals/app/modules/common/views/language_screen.dart';
import 'package:expriy_deals/app/modules/common/views/notification_screen.dart';
import 'package:expriy_deals/app/modules/order/views/oder_screen.dart';
import 'package:expriy_deals/app/modules/profile/controllers/profile_controller.dart';
import 'package:expriy_deals/app/modules/profile/views/change_password_screen.dart';
import 'package:expriy_deals/app/modules/profile/views/edit_profile_screen.dart';
import 'package:expriy_deals/app/modules/profile/views/info_screen.dart';
import 'package:expriy_deals/app/modules/profile/widgets/profile_drawer_feature.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/utils/show_dialog_utils.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    final controller = Get.find<ProfileController>();

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox50,
              Center(
                child: Obx(() {
                  return controller.inProgress
                      ? const CircularProgressIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  controller.profileData?.profile != null
                                      ? NetworkImage(controller.profileData!.profile!)
                                      : const AssetImage(AssetsPath.appleLogo),
                            ),
                            heightBox4,
                            Text(
                              controller.profileData?.name ?? 'info.no_data_message'.tr, // Localized "No data available"
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              controller.profileData?.email ?? 'info.no_data_message'.tr, // Localized "No data available"
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                }),
              ),
              heightBox12,
              ProfileDrawerFeature(
                feature: 'profile.edit_profile_feature'.tr, // Localized "Edit Profile"
                icon: Icons.person,
                ontap: () {
                  if (controller.profileData != null) {
                    Get.to(() => EditProfile(profileData: controller.profileData!));
                  } else {
                    showSnackBarMessage(
                      context,
                      'profile.error_messages.profile_data_not_available'.tr, // Localized "Profile data not available"
                      true,
                    );
                  }
                },
              ),
              ProfileDrawerFeature(
                feature: 'profile.my_orders_feature'.tr, // Localized "My Orders"
                icon: Icons.shopping_bag,
                ontap: () => Get.to(() => const MyOrderScreen(isBack: true)),
              ),
              ProfileDrawerFeature(
                feature: 'profile.language_feature'.tr, // Localized "Language"
                icon: Icons.language,
                ontap: () => Get.to(() => const LanguageScreen()),
              ),
              heightBox8,
              Text(
                'profile.settings_section'.tr, // Localized "Settings"
                style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              heightBox12,
              ProfileDrawerFeature(
                feature: 'profile.notification_feature'.tr, // Localized "Notification"
                icon: Icons.notifications,
                ontap: () => Get.to(() => const NotificationScreen()),
              ),
              ProfileDrawerFeature(
                feature: 'profile.change_password_feature'.tr, // Localized "Change password"
                icon: Icons.lock,
                ontap: () => Get.to(() => const ChangePasswordScreen()),
              ),
              heightBox8,
              Text(
                'profile.support_section'.tr, // Localized "Support"
                style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
              heightBox12,
              ProfileDrawerFeature(
                feature: 'profile.policies_feature'.tr, // Localized "Policies"
                icon: Icons.security,
                ontap: () => Get.to(() => InfoScreen(
                      appBarTitle: 'profile.policies_feature'.tr,
                      param: 'privacyPolicy',
                    )),
              ),
              ProfileDrawerFeature(
                feature: 'profile.about_us_feature'.tr, // Localized "About Us"
                icon: Icons.groups_2_sharp,
                ontap: () => Get.to(() => InfoScreen(
                      appBarTitle: 'profile.about_us_feature'.tr,
                      param: 'aboutUs',
                    )),
              ),
              heightBox14,
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => DialogUtils.showLogoutDialog(context, controller.logout),
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xffFF0000).withOpacity(0.20),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.red),
                        widthBox4,
                        Text(
                          'profile.logout_button'.tr, // Localized "Logout"
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
