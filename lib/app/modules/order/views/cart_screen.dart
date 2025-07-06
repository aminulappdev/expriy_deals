import 'package:expriy_deals/app/modules/order/widgets/cart_product_card.dart';
import 'package:expriy_deals/app/modules/product/controllers/all_card_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/delete_card_controller.dart';
import 'package:expriy_deals/app/modules/product/views/check_out_screen.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
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
    super.initState();
    allCartController.getCart();
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
                'cart.title'.tr, // Localized "My Cart"
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          heightBox12,
          Obx(() {
            if (allCartController.inProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (allCartController.addToCartData == null ||
                allCartController.addToCartData!.isEmpty) {
              return SizedBox(
                height: 500.h,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'cart.no_cart'.tr, // Localized "No cart available"
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
                  itemCount: allCartController.addToCartData!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: CartProductCard(
                        imagePath: allCartController
                                .addToCartData![index].product?.images[0].url ??
                            '',
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
                          deleteCart(allCartController.addToCartData![index].id
                              .toString());
                        },
                        buyOntap: () {
                          if (allCartController
                                  .addToCartData?[index].product !=
                              null) {
                            Get.to(() => CheckOutScreen(
                                  productDetailsData: allCartController
                                      .addToCartData![index].product!,
                                ));
                          } else {
                            debugPrint('Error: productDetailsData is null');
                            showSnackBarMessage(
                                context,
                                'product_details.error_messages.product_data_not_available'
                                    .tr, // Localized error message
                                true);
                          }
                        },
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }

  Future<void> deleteCart(String id) async {
    final bool isSuccess = await deleteCartController.deleteCart(id);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'cart.success_message'.tr); // Localized "Cart deleted"
        allCartController.getCart();
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          deleteCartController.errorMessage ?? 'cart.error_message'.tr, // Localized fallback error message
          true,
        );
      }
    }
  }
}