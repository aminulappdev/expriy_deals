// lib/core/utils/dialog_utils.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expriy_deals/app/widgets/custom_alert_dialoge.dart';

class DialogUtils {
  static void showDeleteAccountDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomAlertDialog(
        title: 'delete_message'.tr,
        noOntap: () => Navigator.pop(context),
        yesOntap: onConfirm,
      ),
    );
  }

  static void showLogoutDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            textAlign: TextAlign.center,
            'logout_message'.tr,
            style: GoogleFonts.poppins(fontSize: 20),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: onConfirm,
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff305FA1).withOpacity(0.1),
                border: Border.all(color: const Color(0xff305FA1)),
              ),
              child: const Center(
                child: Text(
                  'YES',
                  style: TextStyle(color: Color(0xff305FA1), fontSize: 14),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 32.h,
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffA13430).withOpacity(0.1),
                border: Border.all(color: const Color(0xffA13430)),
              ),
              child: const Center(
                child: Text(
                  'NO',
                  style: TextStyle(color: Color(0xffA13430), fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}