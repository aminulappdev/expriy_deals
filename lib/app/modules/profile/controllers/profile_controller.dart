import 'package:expriy_deals/app/modules/profile/model/profile_model.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage; 
  String? get errorMessage => _errorMessage;

  ProfileModel? profileModel;
  ProfileData? get profileData => profileModel?.data;

  Future<bool> getProfileData() async {
    bool isSuccess = false;

    _inProgress = true;

    update();
    print('Access token in profile controller page : ${StorageUtil.getData(StorageUtil.userAccessToken)}');
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        
        Urls.getProfileUrl,
        accesToken: StorageUtil.getData(StorageUtil.userAccessToken));

    if (response.isSuccess) {
      profileModel = ProfileModel.fromJson(response.responseData);
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
