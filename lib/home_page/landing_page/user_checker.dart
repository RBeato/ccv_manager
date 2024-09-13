import 'package:ccv_manager/home_page/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/user_provider.dart';
import '../../authentication/screens/auth/auth_home.dart';

class UserChecker extends ConsumerWidget {
  const UserChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: userAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.teal)),
        error: (err, stack) => Text('Error: $err'),
        data: (data) {
          if (data != null) {
            print("User: ${data.name}");
            return const HomePage();
          } else {
            return const AuthHome();
          }
        },
      ),
    );
  }
}
