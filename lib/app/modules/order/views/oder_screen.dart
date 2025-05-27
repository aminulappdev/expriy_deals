import 'package:expriy_deals/app/modules/order/controllers/my_orders_controller.dart';
import 'package:expriy_deals/app/modules/order/widgets/my_order_card.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
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
    myOrdersController.myOrder();
    super.initState();
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
            CustomAppBar(name: "My Orders",isBack: widget.isBack,),
            heightBox20,
           
            Obx(() {
              if (myOrdersController.inProgress == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Expanded(
                  child: Builder(builder: (context) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: myOrdersController.myOrderData?.length ?? 0,
                      itemBuilder: (context, index) {
                        final order = myOrdersController.myOrderData![index];
                        return MyOrderCard(
                          imagePath: order.product?.images[0].url ?? '',
                          price: order.totalPrice.toString(),
                          productName: order.product?.name ?? '',
                          quantity: order.quantity.toString(),
                          isShowSeconBTN: order.status != 'pending',
                          status: order.status ?? '',
                          mainBTNOntap: () {},
                          secondBTNOntap: () {},
                          secondBTNName: 'Buy Again',
                        );
                      },
                    );
                  }),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
