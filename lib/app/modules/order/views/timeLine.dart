import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingInfoScreen extends StatelessWidget {
  const ShippingInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Information",
          style: GoogleFonts.poppins(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Information",
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: [
                  TimelineStep(
                    date: "April 28, 2023",
                    time: "11:30 AM",
                    description: "Arrived at Logistic Hub",
                    isCompleted: true,
                  ),
                  TimelineStep(
                    date: "April 27, 2023",
                    time: "4:30 PM",
                    description: "Package Picked Up",
                    isCompleted: false,
                  ),
                  TimelineStep(
                    date: "April 26, 2023",
                    time: "9:30 AM",
                    description: "Packed and Ready to Ship",
                    isCompleted: false,
                  ),
                  TimelineStep(
                    date: "April 25, 2023",
                    time: "9:30 AM",
                    description: "Order Confirmed",
                    isCompleted: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final String date;
  final String time;
  final String description;
  final bool isCompleted;
  final bool isLast;

  const TimelineStep({
    super.key,
    required this.date,
    required this.time,
    required this.description,
    this.isCompleted = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              date,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
            ),
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),
        Column(
          children: [
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Colors.orange : Colors.grey,
              ),
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 60.h,
                color: Colors.grey,
              ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}