import 'package:expriy_deals/app/modules/order/views/timeLine.dart';
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  static const String routeName = '/order-details-screen';
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox20,
              CustomAppBar(name: 'Order Details'),
              heightBox14,
              Container(
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
              ),

              heightBox12,
              Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.iconButtonThemeColor,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            ),
                            widthBox10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping Information',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'View',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.iconButtonThemeColor),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Standerd local',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Id : 42561',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox12,
              // Consolidated Shipping Information Card with Timeline
              Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: AppColors.iconButtonThemeColor,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                            widthBox10,                           
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping Information',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Add navigation or action for "View"
                                        },
                                        child: Text(
                                          'View',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.iconButtonThemeColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Standard local',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'Id: 42561',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  ), 
                                  SizedBox(
                                    height: 300.h,
                                    child: ListView(
                                      physics:
                                          NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                                      children: [
                                        TimelineStep(
                                          date: "April 28, 2023",
                                          time: "11:30 AM",
                                          description:
                                              "Arrived at Logistic Hub",
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
                                          description:
                                              "Packed and Ready to Ship",
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox12,
              // Product Details Card
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(AssetsPath.headphone),
                              radius: 20.r,
                            ),
                            widthBox10,
                            Text(
                              'Text therapy',
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        heightBox10,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                  image: AssetImage(AssetsPath.headphone),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            widthBox8,
                            SizedBox(
                              width: 230.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    width: 130.w,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      'Headphone',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  heightBox12,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$50',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Qty: 1',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              heightBox10,
                              Text(
                                'Price Details',
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              PriceRow(
                                name: 'Price',
                                price: '10',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                              PriceRow(
                                name: 'Price',
                                price: '10',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                              PriceRow(
                                name: 'Price',
                                price: '10',
                                nameSize: 14,
                                priceSize: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              heightBox12,
              heightBox12,
              Card(
                color: Colors.white,
                elevation: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.iconButtonThemeColor,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                            ),
                            widthBox10,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Shipping Information',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'View',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.iconButtonThemeColor),
                                      ),
                                    ], 
                                  ),
                                ),
                                Text(
                                  'Standerd local',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Id : 42561',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
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
