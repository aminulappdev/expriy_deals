import 'package:expriy_deals/app/modules/order/controllers/order_controller.dart';
import 'package:expriy_deals/app/modules/order/widgets/price_row.dart';
import 'package:expriy_deals/app/modules/payment/controllers/payment_services.dart';

import 'package:expriy_deals/app/modules/product/model/product_details_model.dart';
import 'package:expriy_deals/app/modules/product/widgets/checkout_user_info.dart';
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

class CheckOutScreen extends StatefulWidget {
  final ProductDetailsData productDetailsData;
  const CheckOutScreen({super.key, required this.productDetailsData});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final ProductOrderController productOrderController =
      Get.find<ProductOrderController>();
  ProfileController profileController = Get.find<ProfileController>();
  // final PaymentService paymentService = PaymentService();
  final PaymentService paymentService = PaymentService();

  int selectedButtonIndex = 0;
  String deliveryAddress = 'Dhaka';

  int quantity = 1;

  late String myUserId;

  dynamic price = 0.0;
  dynamic totalPrice = 0.0;
  double mainTotalPrice = 0.0;
  int discount = 0;
  int item = 1;

  @override
  void initState() {
    super.initState();
    profileController.getProfileData();
    myUserId = profileController.profileData?.id ?? '';

    price = (widget.productDetailsData.price ?? 0.0) * quantity;
    discount = widget.productDetailsData.discount ?? 0;
    _calculateTotalPrice();
    print('Initial: Quantity=$quantity, Price=$price, Total=$mainTotalPrice');
  }

  void _calculateTotalPrice() {
    totalPrice = price * ((100 - discount) / 100); // Shipping fee is $5
    mainTotalPrice = double.parse(totalPrice.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    print('Building CheckOutScreen');
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                CustomAppBar(name: 'Checkout'),
                heightBox12,
                CheckoutUserInfo(
                  city: controller.profileData?.city ?? 'city',
                  zipcode: controller.profileData?.zipCode ?? 'zipcode',
                  country: controller.profileData?.country ?? 'country',
                  name: controller.profileData?.name ?? 'name',
                  number:
                      controller.profileData?.document ?? '+49 176 12345678',
                  status: '',
                  address: controller.profileData?.address ?? 'address',
                  editOntap: () {},
                  addressArrowOntap: () {},
                ),
                heightBox8,
                // Address
                heightBox8,
                SizedBox(
                  width: 170,
                  child: Text(
                    deliveryAddress,
                    style: GoogleFonts.poppins(fontSize: 10.sp),
                  ),
                ),
                heightBox8,
                SizedBox(
                  width: 170,
                  child: Text(
                    'Delivery',
                    style: GoogleFonts.poppins(fontSize: 10.sp),
                  ),
                ),
                heightBox12,
                priceCalculator(context),
                heightBox12,
                Text(
                  'Price Details',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                heightBox12,
                PriceRow(
                  name: 'Price ($item item)',
                  price: price.toStringAsFixed(2),
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,

                PriceRow(
                  name: 'Discount',
                  price: '$discount%',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox4,
                Container(
                  height: 1.5.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                heightBox12,
                PriceRow(
                  name: 'Total Payment:',
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
                                          if (controller.profileData?.address ==
                                              '') {
                                            showSnackBarMessage(
                                              context,
                                              'Please fill-up your address',
                                              true,
                                            );
                                          } else {
                                            productOrderFunction(
                                              controller.profileData?.address ??
                                                  'address',
                                              controller.profileData?.city ??
                                                  'city',
                                              controller.profileData?.state ??
                                                  'state',
                                              controller.profileData?.zipCode ??
                                                  'zipcode',
                                              controller.profileData?.country ??
                                                  'country',
                                            );
                                          }
                                        },
                                        text: isLoading ? '' : 'Place order',
                                      ),
                                    ),
                                    if (isLoading)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                );
                              },
                            )),
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

  Container priceCalculator(BuildContext context) {
    return Container(
      height: 91.h,
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
                      image: widget.productDetailsData.images.isNotEmpty == true
                          ? NetworkImage(
                              '${widget.productDetailsData.images[0].url}')
                          : NetworkImage(
                              'https://defaultimageurl.com/default.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                widthBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard delivery',
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
                                price =
                                    (widget.productDetailsData.price ?? 0.0) *
                                        quantity;
                                item--;
                                _calculateTotalPrice();
                                print(
                                    'Minus: Quantity=$quantity, Price=$price, Total=$mainTotalPrice');
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.remove),
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
                              if (widget.productDetailsData.discount! >
                                  quantity) {
                                quantity++;
                                price =
                                    (widget.productDetailsData.price ?? 0.0) *
                                        quantity;
                                item++;
                                _calculateTotalPrice();
                                print(
                                    'Plus: Quantity=$quantity, Price=$price, Total=$mainTotalPrice');
                              } else {
                                print(
                                    'Cannot increase quantity beyond ${widget.productDetailsData.discount}');
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: AppColors.iconButtonThemeColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                price.toStringAsFixed(2),
                style: GoogleFonts.poppins(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> productOrderFunction(
    String address,
    String city,
    String state,
    String zipCode,
    String country,
  ) async {
    final bool isSuccess = await productOrderController.orderProduct(
      widget.productDetailsData.id!,
      quantity,
      address,
      city,
      state,
      zipCode,
      country,
    );

    if (isSuccess) {
      print('Reference id is...........');
      print(productOrderController.orderResponseData?.id);
      if (mounted) {
        paymentService.payment(
            context,
            productOrderController.orderResponseData?.id ?? 'Id null',
            mainTotalPrice);
        // Get.to(PaymentFieldScreen(
        //   orderId: productOrderController.orderResponseData?.id ?? 'Id null',
        //   price: price,
        // ));
      }
    } else {
      if (mounted) {
        print('Error show ----------------------------------');
        showSnackBarMessage(
            context, productOrderController.errorMessage!, true);
      }
    }
  }
}
