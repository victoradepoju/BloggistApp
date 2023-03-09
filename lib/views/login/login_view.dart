import 'package:bloggist/state/auth/backend/authenticator.dart';
import 'package:bloggist/state/auth/notifiers/auth_state_notifier.dart';
import 'package:bloggist/state/auth/providers/auth_state_provider.dart';
import 'package:bloggist/state/user_info/models/user_info_model.dart';
import 'package:bloggist/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailTextController = useTextEditingController();
    final passwordTextController = useTextEditingController();

    final isLoading = ref.watch(myIsLoadingProvider);

    final nameHasText = useState(false);

    useEffect(() {
      emailTextController.addListener(
        () {
          nameHasText.value = emailTextController.text.isNotEmpty;
        },
      );
      passwordTextController.addListener(
        () {
          nameHasText.value = passwordTextController.text.isNotEmpty;
        },
      );
      return () {};
    }, [emailTextController, passwordTextController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloggist'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter email'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordTextController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Enter password'),
            ),
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton(
                    onPressed: () async {
                      // final apiResponse = await _authenticator.login(
                      //   emailTextController.text,
                      //   passwordTextController.text,
                      // );
                      // print(isLoading);
                      final apiResponse =
                          await ref.read(authStateProvider.notifier).login(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                              );
                      // print(apiResponse.error);
                      // print(isLoading);

                      if (apiResponse.error == null) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => HomeView(
                                    userInfoModel:
                                        apiResponse.data as UserInfoModel,
                                  )),
                          (route) => false,
                        );
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${apiResponse.error}'),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
