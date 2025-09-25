// ignore_for_file: avoid_print
import 'package:expriy_deals/app/modules/order/controllers/order_controller.dart';
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/modules/payment/controllers/payment_services.dart';
import 'package:expriy_deals/app/modules/product/model/product_details_model.dart';
import 'package:expriy_deals/app/modules/profile/controllers/profile_controller.dart';
import 'package:expriy_deals/app/utils/app_colors.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/checkout_user_info.dart';

class CheckOutScreen extends StatefulWidget {
  final ProductDetailsData productDetailsData;
  const CheckOutScreen({super.key, required this.productDetailsData});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final ProductOrderController productOrderController = Get.find<ProductOrderController>();
  final ProfileController profileController = Get.find<ProfileController>();
  final PaymentService paymentService = PaymentService();

  int selectedButtonIndex = 0;
  String deliveryAddress = 'Dhaka';

  int quantity = 1;

  late String myUserId;

  double price = 0.0;
  double totalPrice = 0.0;
  double mainTotalPrice = 0.0;
  int discount = 0;
  int item = 1;
  final double vatRate = 0.0825; // 8.25% VAT

  @override
  void initState() {
    super.initState();
    profileController.getProfileData();
    myUserId = profileController.profileData?.id ?? '';

    discount = widget.productDetailsData.discount ?? 0;
    double originalPrice = widget.productDetailsData.price?.toDouble() ?? 0.0;
    price = originalPrice;
    price = double.parse(price.toStringAsFixed(2));
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    totalPrice = price * quantity;
    double vatAmount = totalPrice * vatRate;
    double sum = totalPrice + vatAmount;

    double discountPercent = double.parse(widget.productDetailsData.discount.toString());
    double discountAmount = sum * (discountPercent / 100);

    mainTotalPrice = double.parse((sum - discountAmount).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(name: 'checkout.app_bar_title'.tr), // Localized "Checkout"
                heightBox12,
                CheckoutUserInfo(
                  city: controller.profileData?.city ?? 'info.no_data_message'.tr, // Localized "No data available"
                  zipcode: controller.profileData?.zipCode ?? 'info.no_data_message'.tr,
                  country: controller.profileData?.country ?? 'info.no_data_message'.tr,
                  name: controller.profileData?.name ?? 'info.no_data_message'.tr,
                  number: controller.profileData?.document ?? '+49 176 12345678',
                  status: '',
                  address: controller.profileData?.address ?? 'info.no_data_message'.tr,
                  editOntap: () {},
                  addressArrowOntap: () {},
                ),
                heightBox8,
                priceCalculator(context),
                heightBox12,
                Text(
                  'checkout.price_details_title'.tr, // Localized "Price Details"
                  style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                heightBox12,
                PriceRow(
                  name: 'checkout.price_label'.tr.replaceFirst('{item}', item.toString()), // Localized "Price ({item} item)"
                  price: (price * quantity).toStringAsFixed(2),
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox12,
                PriceRow(
                  name: 'Sales Tax'.tr,
                  price: "${(totalPrice * vatRate).toStringAsFixed(2)} (8.25%)",
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox12,
                PriceRow(
                  name: 'Discount'.tr,
                  price: "-${widget.productDetailsData.discount} %",
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                Container(
                  height: 1.5.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                heightBox12,
                PriceRow(
                  name: 'checkout.total_payment_label'.tr, // Localized "Total Payment:"
                  price: mainTotalPrice.toStringAsFixed(2),
                  nameSize: 16,
                  priceSize: 16,
                ),
                SizedBox(height: 230),
                Container(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SizedBox(
                          width: 159.w,
                          height: 42.h,
                          child: GetBuilder<ProductOrderController>(
                            builder: (orderController) {
                              bool isLoading = orderController.inProgress;
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  IgnorePointer(
                                    ignoring: isLoading,
                                    child: CustomElevatedButton(
                                      onPressed: () {
                                        debugPrint(">>>>>>> mainTotalPrice $mainTotalPrice");
                                        if (controller.profileData?.address == null || controller.profileData!.address!.isEmpty) {
                                          showSnackBarMessage(
                                            context,
                                            'checkout.error_messages.empty_address'.tr, // Localized "Please fill-up your address"
                                            true,
                                          );
                                        } else {
                                          productOrderFunction(
                                            controller.profileData!.address!,
                                            controller.profileData?.city ?? 'info.no_data_message'.tr,
                                            controller.profileData?.state ?? 'info.no_data_message'.tr,
                                            controller.profileData?.zipCode ?? 'info.no_data_message'.tr,
                                            controller.profileData?.country ?? 'info.no_data_message'.tr,
                                          );
                                        }
                                      },
                                      text: isLoading ? '' : 'checkout.place_order_button'.tr, // Localized "Place order"
                                    ),
                                  ),
                                  if (isLoading)
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget priceCalculator(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 95.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 77.h,
                    width: 75.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: widget.productDetailsData.images.isNotEmpty
                            ? NetworkImage(widget.productDetailsData.images[0].url ?? '')
                            : const NetworkImage('https://defaultimageurl.com/default.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  widthBox8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'checkout.standard_delivery_label'.tr, // Localized "Standard delivery"
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      heightBox14,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity--;
                                  item--;
                                  _calculateTotalPrice();
                                  debugPrint('Minus: Quantity=$quantity, Price=$price, Total=$mainTotalPrice');
                                }
                              });
                            },
                            child: CircleAvatar(
                              radius: 13.r,
                              backgroundColor: Colors.grey,
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          widthBox8,
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.poppins(fontSize: 21.sp),
                          ),
                          widthBox8,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.productDetailsData.stock != null && quantity < widget.productDetailsData.stock!) {
                                  quantity++;
                                  item++;
                                  _calculateTotalPrice();
                                  debugPrint('Plus: Quantity=$quantity, Price=$price, Total=$mainTotalPrice');
                                } else {
                                  debugPrint('Cannot increase quantity beyond ${widget.productDetailsData.stock}');
                                }
                              });
                            },
                            child: CircleAvatar(
                              radius: 13.r,
                              backgroundColor: AppColors.iconButtonThemeColor,
                              child: const Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Text(
              //     price.toStringAsFixed(2),
              //     style: GoogleFonts.poppins(fontSize: 20.sp),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> productOrderFunction(String address, String city, String state, String zipCode, String country) async {
    final bool isSuccess = await productOrderController.orderProduct(
      widget.productDetailsData.id ?? '',
      quantity,
      address,
      city,
      state,
      zipCode,
      country,
    );

    if (isSuccess) {
      if (mounted) {
        paymentService.payment(
          context,
          productOrderController.orderResponseData?.id ?? 'info.no_data_message'.tr, // Localized "No data available"
          mainTotalPrice,
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
          context,
          productOrderController.errorMessage ?? 'checkout.error_messages.order_failed'.tr, // Localized "Failed to place order"
          true,
        );
      }
    }
  }
}