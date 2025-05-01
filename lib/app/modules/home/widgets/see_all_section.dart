
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllSection extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const SeeAllSection({
    super.key, required this.title, required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: 250.w,
            child: Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16.sp,fontWeight: FontWeight.w600),
            )),
        GestureDetector(
          onTap: ontap,
          child: Text(
            'See all..',
            style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.green),
          ),
        )
      ],
    );
  }
}