import 'package:expriy_deals/app/modules/order/controllers/my_orders_controller.dart';
import 'package:expriy_deals/app/modules/order/views/order_details_screen.dart';
import 'package:expriy_deals/app/modules/order/widgets/my_order_card.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key, required this.isBack});
  final bool isBack;

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  final MyOrdersController myOrdersController = Get.find<MyOrdersController>();

  @override
  void initState() {
    super.initState();
    myOrdersController.myOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightBox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widthBox12,
                Text(
                  'my_orders.title'.tr, // Localized "My Orders"
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            heightBox10,
            Obx(() {
              if (myOrdersController.inProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (myOrdersController.myOrderData == null ||
                  myOrdersController.myOrderData!.isEmpty) {
                return SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'my_orders.no_orders'.tr, // Localized "No orders available"
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: myOrdersController.myOrderData?.length ?? 0,
                    itemBuilder: (context, index) {
                      final order = myOrdersController.myOrderData![index];
                      return MyOrderCard(
                        orderId: order.id ?? 'Empty',
                        imagePath: order.product?.images[0].url ?? '',
                        price: order.totalPrice.toString(),
                        productName: order.product?.name ?? '',
                        quantity: order.quantity.toString(),
                        status: order.status ?? '',
                        mainBTNOntap: () {
                          if (order.id != null) {
                            Get.to(() => OrderDetailsScreen(
                                  myOrdersItemModel: order,
                                ));
                          } else {
                            showSnackBarMessage(
                              context,
                              'order_details.error_message'.tr, // Localized error message
                              true,
                            );
                          }
                        },
                        secondBTNOntap: () {
                          if (order.product != null) {
                            Get.to(() => CheckOutScreen(
                                  productDetailsData: order.product!,
                                ));
                          } else {
                            showSnackBarMessage(
                              context,
                              'product_details.error_messages.product_data_not_available'.tr, // Localized error message
                              true,
                            );
                          }
                        },
                        productDetailsData: order.product!,
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}