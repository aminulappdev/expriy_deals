import 'package:expriy_deals/app/modules/order/model/my_orders_model.dart';
import 'package:expriy_deals/app/modules/order/views/timeLine.dart';
import 'package:expriy_deals/app/modules/order/widgets/delivery_banner.dart';
import 'package:expriy_deals/app/modules/order/widgets/delivery_card_info.dart';
import 'package:expriy_deals/app/modules/order/widgets/shop_info_card.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final MyOrdersItemModel myOrdersItemModel;

  static const String routeName = '/order-details-screen';
  const OrderDetailsScreen({super.key, required this.myOrdersItemModel});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var isPending = false;
  var isDelivered = false;
  var isCancelled = false;
  var isOngoing = false;

  @override
  void initState() {
    if (widget.myOrdersItemModel.status == 'pending') {
      isPending = true;
    } else if (widget.myOrdersItemModel.status == 'delivered') {
      isOngoing = true;
      isPending = true;
      isDelivered = true;
    } else if (widget.myOrdersItemModel.status == 'cancelled') {
      isCancelled = true;
    } else if (widget.myOrdersItemModel.status == 'ongoing') {
      isPending = true;
      isOngoing = true;
    }
    super.initState();
  }

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
              DeliveryBanner(),
              heightBox12,

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
                                    height: 240.h,
                                    child: ListView(
                                      physics:
                                          NeverScrollableScrollPhysics(), // Disable scrolling inside ListView
                                      children: [
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description:
                                              "Arrived at Logistic Hub",
                                          isCompleted: isPending,
                                        ),
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description: "Package Picked Up",
                                          isCompleted: isOngoing,
                                        ),
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description: "Order Confirmed",
                                          isCompleted: isDelivered,
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
              DeliveryInformationCard(
                title: 'Deliery Address',
                icon: Icons.car_repair_rounded,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.myOrdersItemModel.user?.name ?? 'name',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.myOrdersItemModel.user?.phoneNumber ?? 'number',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.myOrdersItemModel.billingDetails?.address ??
                          'Address',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              heightBox12,
              // Product Details Card
              ShopInfoCard(
                shopLogo: widget.myOrdersItemModel.author?.shop?.logo ??
                    'https://fastly.picsum.photos/id/134/200/300.jpg?hmac=KN18cCDft4FPM0XJpr7EhZLtUP6Z4cZqtF8KThtTvsI',
                shopName:
                    widget.myOrdersItemModel.author?.shop?.name ?? 'Shop Name',
                productImage: widget.myOrdersItemModel.product?.images[0].url ??
                    'https://fastly.picsum.photos/id/134/200/300.jpg?hmac=KN18cCDft4FPM0XJpr7EhZLtUP6Z4cZqtF8KThtTvsI',
                productName:
                    widget.myOrdersItemModel.product?.name ?? 'Product',
                productPrice: '\$${widget.myOrdersItemModel.product?.price}',
                productQuantity: 'Qty: ${widget.myOrdersItemModel.quantity}',
              ),
              heightBox12,
              DeliveryInformationCard(
                title: 'Order Details',
                icon: Icons.location_on,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order ID: ${widget.myOrdersItemModel.datumId}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Order Status : ${widget.myOrdersItemModel.status}',
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
