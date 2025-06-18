import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class DeleteCartController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteCart(String cartId) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

// \0
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .deleteRequest(Urls.deleteCartById(cartId),
            accesToken: StorageUtil.getData(
                StorageUtil.userAccessToken)); // Replace your api url

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
