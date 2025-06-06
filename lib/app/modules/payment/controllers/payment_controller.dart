import 'package:expriy_deals/app/modules/payment/model/payment_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  PaymentModel? paymentModel;
  PaymentModel? get paymentData => paymentModel;

  Future<bool> getPayment(
    String orderId,
    dynamic price,
  ) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {"order": orderId, "price": price};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.paymentUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      paymentModel = PaymentModel.fromJson(response.responseData);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
