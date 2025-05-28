import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class CardInfoController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> cardInfo(
      String orderId,
      double price,
      String cardNumber,
      String expiryDate,
      String cardCode,
      String firstName,
      String lastName) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "order": orderId,
      "price": 35.982,
      "cardInfo": {
        "cardNumber":cardNumber,
        "expiryDate": expiryDate,
        "cardCode": cardCode,
        "firstName": firstName,
        "lastName": lastName
      }
    };
    print('Controller e asche');
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.paymentUrl, requestBody,accesToken: StorageUtil.getData(StorageUtil.userAccessToken)); // Replace your api url

    if (response.isSuccess) {
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
