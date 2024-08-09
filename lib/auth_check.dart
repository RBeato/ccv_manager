import 'dart:async';

import 'package:ccv_manager/authentication/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'home_page/landing_page/user_checker.dart';
import 'authentication/services/utility_services.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  var logger = Logger();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final UtilityService _utilityService = UtilityService();
  bool _isOnline = true;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    return _isOnline
        ? const UserChecker()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  // LoadingAnimationWidget.staggeredDotsWave(
                  //   color: color2,
                  //   size: 50.0
                  // ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text("Connection failed!"),
                ],
              ),
            ),
          );
  }

  checkConnection() {
    // timer = Timer.periodic(const Duration(seconds: 2), (Timer t) =>
    _utilityService.checkConnectivity().then((value) => {
          if (value != _isOnline)
            {
              setState(() {
                _isOnline = value;
              })
            }
        });
    // );
  }
}
