import 'package:bloggist/state/auth/models/api_response.dart';
import 'package:bloggist/state/user_info/backend/user_info_backend.dart';
import 'package:bloggist/state/user_info/models/user_info_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userInfoProvider = FutureProvider<UserInfoModel?>((ref) async {
  final apiResponse = await const UserInfoBackend().getUserDetails();
  return apiResponse as UserInfoModel;
});
