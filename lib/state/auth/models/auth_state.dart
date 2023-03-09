// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;
import 'package:bloggist/state/user_info/models/user_info_model.dart';

@immutable
class AuthState {
  final UserInfoModel? userInfo;
  final bool isLoading;
  final String? userId;

  const AuthState({
    required this.userInfo,
    required this.isLoading,
    required this.userId,
  });
  // unknown could be called logged out.
  const AuthState.unknown()
      : userInfo = null,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoading) {
    return AuthState(
      userInfo: null,
      isLoading: isLoading,
      userId: userId,
    );
  }

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (userInfo == other.userInfo &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(
        userInfo,
        isLoading,
        userId,
      );
}
