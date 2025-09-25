import 'dart:convert';
import 'package:expriy_deals/app/modules/authentication/views/sign_in_screen.dart';
import 'package:expriy_deals/get_storage.dart';
import 'package:expriy_deals/services/network_caller/error_message_model.dart';
import 'package:expriy_deals/services/network_caller/network_response.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';


class NetworkCaller {
  final Logger _logger = Logger();

  // Method to log out the user
  Future<void> _logout() async {
    try {
      // Remove the token or any other user data
      await GoogleSignIn().signOut(); // Sign out of Google
      await StorageUtil.deleteData(StorageUtil.userAccessToken); // Remove token from storage

      // Navigate to the SignInScreen
      Get.offAll(() => SignInScreen()); // Redirect to sign-in screen
    } catch (e) {
      _logger.e("Logout failed: $e");
    }
  }

  Future<NetworkResponse> getRequest(String url,
      {Map<String, dynamic>? queryParams, String? accesToken}) async {
    try {
      _logRequest(url);

      if (queryParams != null) {
        url += '?';
        for (String param in queryParams.keys) {
          url += '$param=${queryParams[param]}&';
        }
      }
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application-json',
      };

      if (accesToken != null) {
        headers['Authorization'] = 'Bearer $accesToken';
      }

      var response = await get(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 401) {
        await _logout();  // Logout the user if 401 is received
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Unauthorized. Please log in again.');
      }
      if (response.statusCode == 200) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        final debugMessage = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel =
            ErrorMessageModel.fromJson(debugMessage);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessageModel.message ?? 'Wrong');
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> patchRequest(String url,
      {Map<String, dynamic>? queryParams,
      String? accesToken,
      Map<String, dynamic>? body}) async {
    try {
      _logRequest(url);

      if (queryParams != null && queryParams.isNotEmpty) {
        url += '?';
        for (String param in queryParams.keys) {
          url += '$param=${queryParams[param]}&';
        }
        url = url.substring(0, url.length - 1); // remove last "&"
      }

      Uri uri = Uri.parse(url);

      // 🔧 Only set content-type if body is not null
      Map<String, String> headers = {};
      if (body != null) {
        headers['content-type'] = 'application/json';
      }

      if (accesToken != null) {
        headers['Authorization'] = 'Berarer $accesToken';
      }

      _logRequest(url, headers, body);

      // 🔧 Send encoded body only if body is not null
      final response = await patch(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 401) {
        await _logout();  // Logout the user if 401 is received
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Unauthorized. Please log in again.');
      }

      if (response.statusCode == 200) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        final debugMessage = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel =
            ErrorMessageModel.fromJson(debugMessage);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessageModel.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(String url, Map<String, dynamic>? body,
      {String? accesToken}) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      if (accesToken != null) {
        headers['Authorization'] = 'Berarer $accesToken';
      }

      _logRequest(url, headers, body);
      var response = await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        final debugMessage = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel =
            ErrorMessageModel.fromJson(debugMessage);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessageModel.message ?? 'Wrong');
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> putRequest(String url, Map<String, dynamic>? body,
      {String? accesToken}) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      if (accesToken != null) {
        headers['Authorization'] = accesToken;
      }

      _logRequest(url, headers, body);
      var response = await put(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 401) {
        await _logout();  // Logout the user if 401 is received
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Unauthorized. Please log in again.');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> deleteRequest(String url,
      {Map<String, dynamic>? queryParams, String? accesToken}) async {
    try {
      _logRequest(url);

      if (queryParams != null) {
        url += '?';
        for (String param in queryParams.keys) {
          url += '$param=${queryParams[param]}&';
        }
      }
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'content-type': 'application-json',
      };

      if (accesToken != null) {
        headers['Authorization'] ='Bearer $accesToken';
      }

      var response = await delete(uri, headers: headers);
      _logResponse(url, response.statusCode, response.headers, response.body);

      if (response.statusCode == 401) {
        await _logout();  // Logout the user if 401 is received
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Unauthorized. Please log in again.');
      }

      if (response.statusCode == 200) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  Future<NetworkResponse> patchRequestWithToken(String url,
      {Map<String, dynamic>? queryParams,
      String? accesToken,
      Map<String, dynamic>? body}) async {
    try {
      _logRequest(url);

      if (queryParams != null && queryParams.isNotEmpty) {
        url += '?';
        for (String param in queryParams.keys) {
          url += '$param=${queryParams[param]}&';
        }
        url = url.substring(0, url.length - 1); // remove last "&"
      }

      Uri uri = Uri.parse(url);

      // 🔧 Only set content-type if body is not null
      Map<String, String> headers = {};
      if (body != null) {
        headers['content-type'] = 'application/json';
      }

      if (accesToken != null) {
        headers['token'] = accesToken;
      }

      _logRequest(url, headers, body);

      // 🔧 Send encoded body only if body is not null
      final response = await patch(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );

      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 401) {
        await _logout();  // Logout the user if 401 is received
        return NetworkResponse(
            isSuccess: false,
            statusCode: 401,
            errorMessage: 'Unauthorized. Please log in again.');
      }


      if (response.statusCode == 200) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        final debugMessage = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel =
            ErrorMessageModel.fromJson(debugMessage);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessageModel.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequestWithToken(
      String url, Map<String, dynamic>? body,
      {String? accesToken}) async {
    try {
      Uri uri = Uri.parse(url);

      Map<String, String> headers = {
        'content-type': 'application/json',
      };

      if (accesToken != null) {
        headers['token'] = accesToken;
      }

      _logRequest(url, headers, body);
      var response = await post(uri, headers: headers, body: jsonEncode(body));
      _logResponse(url, response.statusCode, response.headers, response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final debugMessage = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: debugMessage,
        );
      } else {
        final debugMessage = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel =
            ErrorMessageModel.fromJson(debugMessage);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMessageModel.message ?? 'Wrong');
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  void _logRequest(String url,
      [Map<String, dynamic>? headers, Map<String, dynamic>? body]) {
    _logger.i('URL => $url\nHeaders => $headers\nBODY => $body');
  }

  void _logResponse(
      String url, int statusCode, Map<String, String>? headers, String body,
      [String? errorMessage]) {
    if (errorMessage != null) {
      _logger.e('URL => $url\Error Message => $errorMessage');
    } else {
      _logger.i(
          'URL => $url\nHeaders => $headers\nStatusCode => $statusCode \nBODY => $body');
    }
  }
}
