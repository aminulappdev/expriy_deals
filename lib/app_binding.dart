import 'package:expriy_deals/app/modules/authentication/controllers/create_user_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/forgot_password_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/otp_verify_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/resend_otp_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/reset_password_controller.dart';
import 'package:expriy_deals/app/modules/authentication/controllers/sign_in_controller.dart';
import 'package:expriy_deals/app/modules/order/controllers/my_orders_controller.dart';
import 'package:expriy_deals/app/modules/order/controllers/order_controller.dart';
import 'package:expriy_deals/app/modules/payment/controllers/confirmed_payment_controller.dart';
import 'package:expriy_deals/app/modules/payment/controllers/payment_controller.dart';

import 'package:expriy_deals/app/modules/product/controllers/all_card_controller.dart';
import 'package:expriy_deals/app/modules/product/controllers/delete_card_controller.dart';
import 'package:expriy_deals/app/modules/profile/controllers/edit_profile_controller.dart';
import 'package:expriy_deals/app/modules/profile/controllers/profile_controller.dart';
import 'package:expriy_deals/app/modules/seller/controllers/all_shop_controller.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkCaller());
    Get.put(CreateUserController());
    Get.put(OtpVerifyController());
    Get.put(SignInController());
    Get.put(ForgotPasswordController());
    Get.put(ResendOTPController());
    Get.put(ResetPasswordController());
    Get.put(ProfileController());
    Get.put(EditProfileController());
    Get.put(ProductOrderController());
    Get.put(AllCartController());
    Get.put(DeleteCartController());
    Get.put(MyOrdersController());
    Get.put(AllShopController());
    Get.put(PaymentController());
    Get.put(ConfirmedPaymentController());
    
  }
}
