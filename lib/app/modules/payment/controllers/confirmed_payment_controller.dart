
import 'package:expriy_deals/app/modules/payment/model/confirmed_payment_response_model.dart';
import 'package:expriy_deals/app/utils/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class ConfirmedPaymentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;
 
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ConfirmedPaymentResponseModel? confirmedPaymentResponseModel;
  ConfirmedPaymentResponseItemModel? get paymentDetails => confirmedPaymentResponseModel?.data;

  Future<bool> confirmPaymentfunction(String id) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(Urls.confirmedPaymentUrlsById(id));

    if (response.isSuccess) {
      confirmedPaymentResponseModel = ConfirmedPaymentResponseModel.fromJson(response.responseData);
      box.write('payment-reference-id', id); 
// \0
// \0
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
