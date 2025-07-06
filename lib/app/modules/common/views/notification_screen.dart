
import 'package:expriy_deals/app/modules/common/controllers/notification_controller.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final AllNotificationController allNotificationController = Get.put(AllNotificationController());

  @override
  void initState() {
    super.initState();
    allNotificationController.getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AllNotificationController>(builder: (controller) {
        if (controller.inProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'notification_screen.app_bar_title'.tr), // Localized "Notification"
              heightBox5,
              Text(
                'notification_screen.all_notifications'.tr, // Localized "All notifications"
                style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              heightBox8,
              controller.notificationList?.data.isEmpty ?? true
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'notification_screen.no_notification'.tr, // Localized "No notification"
                          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.notificationList?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          DateTime? isoDate = controller.notificationList?.data[index].createdAt;
                          String readableDate = isoDate != null
                              ? DateFormat('MMMM dd, yyyy').format(isoDate)
                              : 'notification.unknown_date'.tr; // Localized "Unknown date"
                          String readableTime = isoDate != null
                              ? DateFormat('h:mm a').format(isoDate)
                              : 'notification.unknown_time'.tr; // Localized "Unknown time"
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: AppColors.iconButtonThemeColor),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 200.w,
                                          child: Text(
                                            controller.notificationList?.data[index].message ??
                                                'notification.no_message'.tr, // Localized "No message"
                                            style: GoogleFonts.poppins(
                                              color: AppColors.iconButtonThemeColor,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          readableTime,
                                          style: GoogleFonts.poppins(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    heightBox4,
                                    Text(
                                      controller.notificationList?.data[index].description ??
                                          'notification.no_description'.tr, // Localized "No description"
                                      style: GoogleFonts.poppins(fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
