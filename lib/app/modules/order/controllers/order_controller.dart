// ✅ Fixed ProductOrderController

import 'package:expriy_deals/app/modules/order/model/order_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class ProductOrderController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  OrderModel? orderResponseModel;
  OrderItemModel? get orderResponseData => orderResponseModel?.data;

  Future<bool> orderProduct(
    String productId,
    int quantity,
    String address,
    String city,
    String state,
    String zipCode,
    String country,
  ) async {
    _inProgress = true;
    update();

    bool isSuccess = false;

    Map<String, dynamic> requestBody = {
      "product": productId,
      "quantity": quantity,
      "billingDetails": {
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "country": country
      }
    };

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.ordertUrl, requestBody,
            accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      orderResponseModel = OrderModel.fromJson(response.responseData);
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
