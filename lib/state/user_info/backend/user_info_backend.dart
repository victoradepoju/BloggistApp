import 'dart:convert';
import 'dart:io';

import 'package:bloggist/state/auth/constants/constants.dart';
import 'package:bloggist/state/auth/models/api_response.dart';
import 'package:bloggist/state/user_info/models/user_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoBackend {
  const UserInfoBackend();

  // User
  Future<UserInfoModel?> getUserDetails() async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();
      final response = await http.get(
        Uri.parse(AuthConstants.userUrl),
        headers: {
          AuthConstants.headerKeyAccept: AuthConstants.headerValueJson,
          AuthConstants.headerKeyAuth: 'Bearer $token',
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          apiResponse.data = UserInfoModel.fromJson(
            responseBody,
          );
          break;
        case 401:
          apiResponse.error = AuthConstants.unauthorized;
          break;
        // case 403:
        //   apiResponse.error = jsonDecode(response.body)['message'];
        //   break;
        default:
          apiResponse.error = AuthConstants.somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = AuthConstants.serverError;
    }

    return apiResponse.data as UserInfoModel;
  }

  // Update User
  Future<ApiResponse> updateUser(String name, String? image) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      String token = await getToken();
      final response = await http.put(Uri.parse(AuthConstants.userUrl),
          headers: {
            AuthConstants.headerKeyAccept: AuthConstants.headerValueJson,
            AuthConstants.headerKeyAuth: 'Bearer $token',
          },
          body: image == null
              ? {
                  AuthConstants.name: name,
                }
              : {
                  AuthConstants.name: name,
                  AuthConstants.image: image,
                });

      switch (response.statusCode) {
        case 200:
          apiResponse.data = jsonDecode(response.body)['message'];
          break;
        case 401:
          apiResponse.error = AuthConstants.unauthorized;
          break;
        // case 403:
        //   apiResponse.error = jsonDecode(response.body)['message'];
        //   break;
        default:
          print(response.body);
          apiResponse.error = AuthConstants.somethingWentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = AuthConstants.serverError;
    }

    return apiResponse;
  }

  // get token
  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  // get user id
  Future<int> getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId') ?? 0;
  }

  // Get base64 encoded image
  String? getStringImage(File? file) {
    if (file == null) {
      return null;
    }
    return base64Encode(file.readAsBytesSync());
  }
}
