
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryBanner extends StatelessWidget {
  const DeliveryBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Color(0xff308960),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipped',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Your order is on the way!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            Icon(
              FontAwesomeIcons.truckFast,
              size: 30.sp,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}