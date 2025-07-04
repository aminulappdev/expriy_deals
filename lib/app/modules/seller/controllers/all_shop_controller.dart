import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/seller/model/all_shop_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class AllShopController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  final Rx<AllShopModel?> allShopModel = Rx<AllShopModel?>(null);
  List<AllShopItemModel>? get allShopData =>
      allShopModel.value!.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
    // getCategory(Get.arguments);
  }

  Future<bool> myShops({double? latitude, double? longitude}) async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    if (token == null) {
      Get.to(SignInScreen());
      return false;
    }

    _inProgress.value = true;
// \0
    Map<String, dynamic> queryparam = {
      'longitude': longitude,
      'latitude': latitude
    };
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.allShopsUrl,
        queryParams: latitude != null && longitude != null ? queryparam : null,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;
// \0
      allShopModel.value = AllShopModel.fromJson(response.responseData);
      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
