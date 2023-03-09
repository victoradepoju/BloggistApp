import 'dart:convert';

import 'package:bloggist/state/auth/constants/constants.dart';
import 'package:bloggist/state/auth/models/api_response.dart';
import 'package:bloggist/state/user_info/models/user_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authenticator {
  const Authenticator();

  // login
  Future<ApiResponse> login(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(
        Uri.parse(AuthConstants.loginUrl),
        headers: {
          AuthConstants.headerKeyAccept: AuthConstants.headerValueJson,
        },
        body: {
          AuthConstants.email: email,
          AuthConstants.password: password,
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          apiResponse.data = UserInfoModel.fromJson(
            responseBody,
          );

          // final pref = await SharedPreferences.getInstance();
          // await pref.setString(
          //   'token',
          //   (apiResponse.data as UserInfoModel).token!,
          // );

          // await pref.setInt(
          //   'token',
          //   (apiResponse.data as UserInfoModel).id!,
          // );
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        // default:
        //   apiResponse.error = AuthConstants.somethingWentWrong;
        //   break;
      }
    } catch (e) {
      apiResponse.error = 'Did not reach backend at all';
    }
    return apiResponse;
  }

  // Register
  Future<ApiResponse> register(
    String name,
    String email,
    String password,
  ) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(
        Uri.parse(AuthConstants.registerUrl),
        headers: {
          AuthConstants.headerKeyAccept: AuthConstants.headerValueJson,
        },
        body: {
          AuthConstants.name: name,
          AuthConstants.email: email,
          AuthConstants.password: password,
          AuthConstants.passwordConfirmation: password,
        },
      );

      switch (response.statusCode) {
        case 200:
          final responseBody = jsonDecode(response.body);
          apiResponse.data = UserInfoModel.fromJson(
            responseBody,
          );

          final pref = await SharedPreferences.getInstance();
          await pref.setString(
            'token',
            (apiResponse.data as UserInfoModel).token!,
          );

          await pref.setInt(
            'token',
            (apiResponse.data as UserInfoModel).id!,
          );
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
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
    return apiResponse;
  }

  // logout
  Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }
}
