import 'package:expriy_deals/app/modules/order/widgets/cart_product_card.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_card_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/delete_card_controller.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/utils/assets_path.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final AllCartController allCartController = Get.find<AllCartController>();
  final DeleteCartController deleteCartController =
      Get.find<DeleteCartController>();
  @override
  void initState() {
    allCartController.getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heightBox24,
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widthBox12,
                Text(
                  'My Cart',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          heightBox12,
          Obx(() {
            if (allCartController.inProgress == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: allCartController.addToCartData!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: CartProductCard(
                        imagePath: allCartController
                                .addToCartData![index].product?.images[0].url ?? '',
                        title: allCartController
                                .addToCartData![index].product?.name ??
                            '',
                        brand: allCartController.addToCartData![index].product!
                                .category?.name ??
                            '',
                        color: '',
                        quantity: allCartController
                            .addToCartData![index].quantity
                            .toString(),
                        price: allCartController
                                .addToCartData![index].product?.price
                                .toString() ??
                            '',
                        deleteOntap: () {
                          deleteContact(allCartController
                              .addToCartData![index].id
                              .toString());
                        },
                        buyOntap: () {
                          allCartController.addToCartData?[index].product !=
                                  null
                              ? Get.to(CheckOutScreen(
                                  productDetailsData: allCartController
                                      .addToCartData![index].product!,
                                ))
                              : printError(info: 'productDetailsData is null');
                        },
                      ),
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }

  Future<void> deleteContact(String id) async {
    final bool isSuccess = await deleteCartController.deleteCart(id);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Deleted cart');
        Get.find<AllCartController>().getCart();
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, deleteCartController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(context, deleteCartController.errorMessage!, true);
      }
    }
  }
}
