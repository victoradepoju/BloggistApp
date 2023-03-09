import 'package:bloggist/state/auth/backend/authenticator.dart';
import 'package:bloggist/state/auth/models/api_response.dart';
import 'package:bloggist/state/auth/models/auth_state.dart';
import 'package:bloggist/state/auth/providers/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier(this.authenticator) : super(const AuthState.unknown());

  Authenticator authenticator;

  AuthState get authState => state;

  Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWithIsLoading(true);
      print(state.isLoading);
      return await authenticator.login(email, password);
      // state = state.copyWithIsLoading(false);
    } catch (e) {
      state = state.copyWithIsLoading(false);
      return ApiResponse();
    }
  }
}

final myIsLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider.notifier).authState.isLoading;
});
