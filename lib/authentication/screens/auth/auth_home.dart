import 'package:flutter/material.dart';

class AuthHome extends StatefulWidget {
  const AuthHome({Key? key}) : super(key: key);

  @override
  State<AuthHome> createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("CCV Manager"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Opacity(
                opacity: 0.03,
                child: Image.asset(
                  'assets/images/vv_no_background.png',
                ),
              ),
            ),
          ),
          const SignInScreen(
            title: 'Entrar',
          ),
        ],
      ),
    );
  }
}
