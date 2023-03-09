// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloggist/state/auth/notifiers/auth_state_notifier.dart';
import 'package:bloggist/state/auth/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bloggist/state/user_info/models/user_info_model.dart';

class HomeView extends ConsumerWidget {
  final UserInfoModel userInfoModel;
  const HomeView({
    super.key,
    required this.userInfoModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          Text('name: ${userInfoModel.name}'),
          Text('email: ${userInfoModel.email}'),
          Text('id: ${userInfoModel.id}'),
        ],
      ),
    );
  }
}
