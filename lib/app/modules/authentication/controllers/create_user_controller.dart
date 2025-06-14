// // ignore_for_file: avoid_print

// import 'dart:convert';
// import 'dart:io';
// import 'package:expriy_deals/app/modules/authentication/model/create_user_response_model.dart';
// import 'package:expriy_deals/urls.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

// class CreateUserController extends GetxController {
//   bool _inProgress = false;
//   bool get inProgress => _inProgress;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   String? _accessToken;
//   String? get accessToken => _accessToken;

//   CreateUserResponseModel? createUserResponseModel;
//   CreateUserResponseItemModel? get createUserData =>
//       createUserResponseModel?.data;

//   /// 🔁 Update Profile Function
//   Future<bool> createUser(String name, String des, String email,
//       String password) async {
//     bool isSuccess = false;
//     _inProgress = true;
//     update();
//     print('Controller e asche');
//     try {
//       var uri = Uri.parse(Urls.createUserUrl);
//       var request = http.MultipartRequest('POST', uri);

//       // ✅ Set 'data' field with JSON-encoded string
//       Map<String, dynamic> jsonFields = {
//         "name": name,
//         "email": email,
//         "description": des,
//         "password": password,
//       };

//       request.fields['data'] = jsonEncode(jsonFields);

//       // ✅ Add image if available
//       if (image != null) {
//         print('Image ache ekhane ................................');
//         print(image);
//         String imagePath = image.path;
//         String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';

//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'profile', // 🔑 Backend should expect this key
//             imagePath,
//             contentType: MediaType.parse(mimeType),
//           ),
//         );
//       }

//       // 📡 Send request
//       var streamedResponse = await request.send();
//       var responseBody = await streamedResponse.stream.bytesToString();

//       print('📥 Server Response:');
//       print(responseBody);

//       var decodedResponse = jsonDecode(responseBody) as Map<String, dynamic>;
//       // var decodedResponse = jsonDecode(responseBody);

//       if (streamedResponse.statusCode == 200) {
//         createUserResponseModel =
//             CreateUserResponseModel.fromJson(decodedResponse);

//         print('Model Token : ${createUserData?.otpToken?.token}');
//         print('Token : ${decodedResponse['data']['otpToken']['token']}');

//         _errorMessage = null;
//         isSuccess = true;
//       } else {
//         _errorMessage =
//             decodedResponse['message'] ?? "Failed to update profile";
//       }
//     } catch (e) {
//       _errorMessage = "Error updating profile: $e";
//     } finally {
//       _inProgress = false;
//       update();
//     }

//     return isSuccess;
//   }
// }

import 'package:expriy_deals/app/modules/authentication/model/create_user_response_model.dart';
import 'package:expriy_deals/services/network_caller/network_caller.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:expriy_deals/urls.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  CreateUserResponseModel? createUserResponseModel;
  CreateUserResponseItemModel? get createUserData =>
      createUserResponseModel?.data;

  Future<bool> createUser(
      String name, String number, String email, String password) async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "phoneNumber": number,
      "password": password,
    };
    print('Controller e asche');
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(Urls.createUserUrl, requestBody); // Replace your api url

    if (response.isSuccess) {
      // Save access token using await and ensure data is saved before moving forward
        createUserResponseModel =
            CreateUserResponseModel.fromJson(response.responseData);
     
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
