
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAboutScreen extends StatelessWidget {
  final Map<String, dynamic> sellerData;

  const SellerAboutScreen({
    super.key,
    required this.sellerData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12.sp),
              text: 'seller_about.store_name_label'.tr, // Localized "Store Name: "
              children: [
                TextSpan(
                  text: sellerData['shopName']?.toString() ?? 'seller_about.unknown_store'.tr, // Localized "Unknown Store"
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          heightBox12,
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12.sp),
              text: 'seller_about.owner_name_label'.tr, // Localized "Owner Name: "
              children: [
                TextSpan(
                  text: sellerData['sellerName']?.toString() ?? 'seller_about.unknown_owner'.tr, // Localized "Unknown Owner"
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          heightBox12,
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 12.sp),
              text: 'seller_about.store_description_label'.tr, // Localized "Store Description: "
              children: [
                TextSpan(
                  text: sellerData['description']?.toString() ?? 'seller_about.no_description'.tr, // Localized "No Description"
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          heightBox12,
          Text(
            'seller_about.location_label'.tr, // Localized "Location"
            style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          heightBox12,
          Text(
            sellerData['location']?.toString() ?? 'seller_about.unknown_location'.tr, // Localized "Unknown Location"
            style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
          heightBox12,
          Text(
            'seller_about.contact_information_label'.tr, // Localized "Contact Information"
            style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w600),
          ),
          heightBox12,
          Text(
            sellerData['phone']?.toString() ?? 'seller_about.no_phone'.tr, // Localized "N/A"
            style: GoogleFonts.poppins(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
