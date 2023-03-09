import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isLoggedInProvider = FutureProvider<bool>((ref) async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('token') != '';
});
