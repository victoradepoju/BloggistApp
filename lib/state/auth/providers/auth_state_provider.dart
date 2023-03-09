import 'package:bloggist/state/auth/backend/authenticator.dart';
import 'package:bloggist/state/auth/models/auth_state.dart';
import 'package:bloggist/state/auth/notifiers/auth_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  Authenticator authenticator = const Authenticator();
  return AuthStateNotifier(authenticator);
});
