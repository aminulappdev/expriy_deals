import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/app/modules/common/model/contents_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';


class ContentController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  ContentsModel? contentsModel;
  ContentData? get contetData => contentsModel?.data;

  int? lastPage;

  Future<bool> contentData({required String param}) async {
    final token = StorageUtil.getData(StorageUtil.userAccessToken);
    if (token == null) {
      Get.to(SignInScreen());
      return false;
    }

    bool isSuccess = false;

    _inProgress = true;

    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(Urls.contentByParam, accesToken: token);

    if (response.isSuccess) {
      contentsModel = ContentsModel.fromJson(response.responseData);
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
