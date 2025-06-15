import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/common/model/contents_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class ContentController extends GetxController {
  var _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  ContentsModel? contentsModel;
  ContentData? get contetData => contentsModel?.data;

  @override
  void onInit() {
    super.onInit();
    // getCategory(Get.arguments);
  }

  Future<bool> contentData({required String param}) async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    if (token == null) {
      Get.to(SignInScreen());
      return false;
    }

    _inProgress = true;

    Map<String, dynamic> params = {"name": param};

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        Urls.contentByParam,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      _errorMessage = null;

      contentsModel = ContentsModel.fromJson(response.responseData);
      _inProgress = false;
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      return false;
    }
  }
}
