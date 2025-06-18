import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class OtpVerifyController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> otyVerify(String otp, String token) async {
    bool isSuccess = false;

    _inProgress = true;

    update();

    Map<String, dynamic> requestBody = {"otp": otp};

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequestWithToken(Urls.otpVerifyrUrl, requestBody,
            accesToken: token);

    if (response.isSuccess) {
      StorageUtil.saveData(
          StorageUtil.userAccessToken, response.responseData['data']['token']);
      print(
          'Save access token from otp verifiy controller .........................');
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
