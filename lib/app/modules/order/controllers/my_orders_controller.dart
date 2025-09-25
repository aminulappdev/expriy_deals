import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/order/model/my_orders_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  final Rx<MyOrdersModel?> myOrderModel = Rx<MyOrdersModel?>(null);
  List<MyOrdersItemModel>? get myOrderData =>
      myOrderModel.value!.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
    // getCategory(Get.arguments);
  }

  // Map<String, dynamic> get queryParams {
  //   return {
  //   //  'page': 1,
  //     'limit': 9999999999999999,
  //   };
  // }

  Future<bool> myOrder() async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    if (token == null) {
      Get.to(SignInScreen());
      return false;
    }

    _inProgress.value = true;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
    //    queryParams: queryParams,
        Urls.myOrderUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;

      myOrderModel.value = MyOrdersModel.fromJson(response.responseData);
      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
