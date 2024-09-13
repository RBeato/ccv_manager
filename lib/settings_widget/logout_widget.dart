import 'package:ccv_manager/authentication/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/custom_elevated_button.dart';
import '../home_page/landing_page/user_checker.dart';
import '../home_page/provider/user_provider.dart';
import '../services/user_manager.dart';

class LogoutWidget extends ConsumerStatefulWidget {
  const LogoutWidget({super.key});

  @override
  ConsumerState<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends ConsumerState<LogoutWidget> {
  final bool _isSignedIn = false;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Logout: "),
        CustomElevatedButton(
            text: "Sair",
            icon: Icons.account_box_rounded,
            onPressed: () {
              _showLogoutDialog();
            }),
      ],
    );
  }

  _showLogoutDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Prosseguir com o logout?"),
            content: SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.02, // 50% of screen height
              width: MediaQuery.of(context).size.width *
                  0.2, // 80% of screen width
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("CANCELAR"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog

                  await _firebaseAuthService.signOut();
                  await UserManager.logoutUser();

                  bool isSignedIn = FirebaseAuth.instance.currentUser != null;
                  print("Is signed in: $isSignedIn");

                  if (!isSignedIn) {
                    print("Going to login page");
                    var val = ref.refresh(userProvider);
                    print(val);

                    await goToUserCheckerPage();
                  } else {
                    print("Failed to go to login page");
                  }
                },
                child: const Text("SIM"),
              ),
            ],
          );
        });
  }

  goToUserCheckerPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserChecker()),
        (route) => false);
  }
}
