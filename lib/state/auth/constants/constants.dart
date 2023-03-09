import 'package:flutter/foundation.dart' show immutable;

@immutable
class AuthConstants {
  // GET Urls
  static const baseUrl = 'http://127.0.0.1:8000/api';
  static const loginUrl = '$baseUrl/login';
  static const registerUrl = '$baseUrl/register';
  static const userUrl = '$baseUrl/user';
  static const logoutUrl = '$baseUrl/logout';
  static const postsUrl = '$baseUrl/posts';
  static const commentsUrl = '$baseUrl/comments';

  static const headerKeyAccept = 'Accept';
  static const headerValueJson = 'application/json';
  static const headerKeyAuth = 'Authorization';

  static const name = 'name';
  static const email = 'email';
  static const password = 'password';
  static const image = 'image';
  static const passwordConfirmation = 'password_confirmation';

  // Errors
  static const serverError = 'Server error';
  static const unauthorized = 'Unauthorized';
  static const somethingWentWrong = 'Something went wrong, try again!';

  const AuthConstants._();
}
