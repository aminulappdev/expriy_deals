import 'package:expriy_deals/app/modules/common/views/main_bottom_nav_bar.dart';
import 'package:expriy_deals/app/modules/payment/controllers/card_info_controller.dart';
import 'package:expriy_deals/app/utils/responsive_size.dart';
import 'package:expriy_deals/app/widgets/costom_app_bar.dart';
import 'package:expriy_deals/app/widgets/gradiant_elevated_button.dart';
import 'package:expriy_deals/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentFieldScreen extends StatefulWidget {
  final String orderId;
  final double price;
  const PaymentFieldScreen(
      {super.key, required this.orderId, required this.price});

  @override
  State<PaymentFieldScreen> createState() => _PaymentFieldScreenState();
}

class _PaymentFieldScreenState extends State<PaymentFieldScreen> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardCodeController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CardInfoController cardInfoController = Get.find<CardInfoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            heightBox24,
            CustomAppBar(name: 'Payment'),
            heightBox8,
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Number',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: cardNumberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter card number';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: '159-456-7890-1234',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox12,
                  Text('Expiry Date',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: expiryDateController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter expiry date';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'MM/YY',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox12,
                  Text('Card Code',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: cardCodeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter card code';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: '123',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox12,
                  Text('First Name',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: firstNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter first name';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'first name',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox12,
                  Text('Last Name',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: lastNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.isEmpty) return 'Enter last name';
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: '159-456-7890-1234',
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox24,
                  GetBuilder<CardInfoController>(
                    builder: (controller) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomElevatedButton(
                            onPressed: controller.inProgress
                                ? () {}
                                : () => onTapToNextButton(
                                    widget.orderId,
                                    widget.price,
                                    cardNumberController.text,
                                    expiryDateController.text,
                                    cardCodeController.text,
                                    firstNameController.text,
                                    lastNameController.text),
                            text: controller.inProgress ? '' : 'Submit',
                          ),
                          if (controller.inProgress)
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(
      String orderId,
      double price,
      String cardNumber,
      String expiryDate,
      String cardCode,
      String firstName,
      String lastName) async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await cardInfoController.cardInfo(orderId, price,
          cardNumber, expiryDate, cardCode, firstName, lastName);

      if (isSuccess) {
        if (mounted) {
          Get.offAll(MainButtonNavbarScreen());
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, cardInfoController.errorMessage ?? 'Failed', true);
        }
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, cardInfoController.errorMessage ?? 'Login failed', true);
      }
    }
  }
}
