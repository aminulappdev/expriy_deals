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
import 'package:get/get.dart';

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
    super.initState();
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
              CustomAppBar(name: 'order_details.app_bar_title'.tr), // Localized "Order Details"
              heightBox14,
              DeliveryBanner(),
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
                                  Text(
                                    'order_details.shipping_info_title'.tr, // Localized "Shipping Information"
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'order_details.shipping_method'.tr, // Localized "Local Standard"
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    'order_details.shipping_id_label'.tr, // Localized "Id: 42561"
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 240.h,
                                    child: ListView(
                                      physics: const NeverScrollableScrollPhysics(),
                                      children: [
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description: 'order_details.timeline_steps[0].description'.tr, // Localized "Arrived at Logistic Hub"
                                          isCompleted: isPending,
                                        ),
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description: 'order_details.timeline_steps[1].description'.tr, // Localized "Package Picked Up"
                                          isCompleted: isOngoing,
                                        ),
                                        TimelineStep(
                                          date: "",
                                          time: "",
                                          description: 'order_details.timeline_steps[2].description'.tr, // Localized "Order Confirmed"
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
                title: 'order_details.delivery_address_title'.tr, // Localized "Delivery Address"
                icon: Icons.car_repair_rounded,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.myOrdersItemModel.user?.name ?? 'info.no_data_message'.tr, // Localized fallback "No data available"
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.myOrdersItemModel.user?.phoneNumber ?? 'info.no_data_message'.tr, // Localized fallback "No data available"
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      widget.myOrdersItemModel.billingDetails?.address ?? 'info.no_data_message'.tr, // Localized fallback "No data available"
                      style: const TextStyle(fontWeight: FontWeight.w400),
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
                    widget.myOrdersItemModel.author?.shop?.name ?? 'seller_about.store_name_label'.tr, // Localized fallback "Store Name: "
                productImage: widget.myOrdersItemModel.product?.images[0].url ??
                    'https://fastly.picsum.photos/id/134/200/300.jpg?hmac=KN18cCDft4FPM0XJpr7EhZLtUP6Z4cZqtF8KThtTvsI',
                productName:
                    widget.myOrdersItemModel.product?.name ?? 'info.no_data_message'.tr, // Localized fallback "No data available"
                productPrice: '\$${widget.myOrdersItemModel.product?.price ?? '0'}',
                productQuantity: 'Qty: ${widget.myOrdersItemModel.quantity}',
              ),
              heightBox12,
              DeliveryInformationCard(
                title: 'order_details.order_details_title'.tr, // Localized "Order Details"
                icon: Icons.location_on,
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'order_details.order_id_label'.tr + (widget.myOrdersItemModel.datumId ?? 'info.no_data_message'.tr), // Localized "Order ID: "
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'order_details.order_status_label'.tr + (widget.myOrdersItemModel.status ?? 'info.no_data_message'.tr), // Localized "Order Status: "
                      style: const TextStyle(fontWeight: FontWeight.w400),
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