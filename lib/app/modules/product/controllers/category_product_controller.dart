import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/product/model/product_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class CategoryProductController extends GetxController {
  final RxBool _inProgress = false.obs;
  bool get inProgress => _inProgress.value;

  RxString? _errorMessage = ''.obs;
  String? get errorMessage => _errorMessage?.value;

  final Rx<ProductModel?> _productModel = Rx<ProductModel?>(null);
  List<ProductItemModel>? get productData =>
      _productModel.value!.data?.data ?? [];

  @override
  void onInit() {
    super.onInit();
    // getCategory(Get.arguments);
  }

  Future<bool> getProductByCategory({String? categoryId}) async {
    print('Caregory controller e asche ...');
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    if (token == null) {
      Get.to(SignInScreen());
      return false;
    }

    _inProgress.value = true;

    Map<String, dynamic> queryparamByCategory = {
      'category': categoryId,
      'limit': 99999
    };

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.productUrl,
        queryParams: queryparamByCategory,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;

      _productModel.value = ProductModel.fromJson(response.responseData);
      _inProgress.value = false;
      return true;
    } else {
      _errorMessage?.value = response.errorMessage;
      _inProgress.value = false;
      return false;
    }
  }
}
