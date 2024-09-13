import 'package:ccv_manager/authentication/services/firebase_auth_service.dart';
import 'package:ccv_manager/authentication/styles/colors/colors.dart';
import 'package:ccv_manager/authentication/styles/input_fields.dart';
import 'package:ccv_manager/home_page/landing_page/user_checker.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../constants/constants.dart';
import '../../../home_page/provider/user_provider.dart';
import '../../../services/user_manager.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  var logger = Logger();
  // final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final _signInForm = GlobalKey<FormState>();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  String email = "";
  String pass = "";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String _signInError = "";
  // bool _isSignIn = true;

  bool isEmail(String input) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return regex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "Entrar",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              "Bem-vindo de volta!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: Form(
                key: _signInForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      decoration: inputFieldContainer,
                      child: TextFormField(
                        style: inputFieldText,
                        controller: emailController,
                        decoration: emailField,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) => val!.isEmpty
                            ? "Introduza o seu email"
                            : (!isEmail(val)
                                ? "Introduza um email válido"
                                : null),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      decoration: inputFieldContainer,
                      child: TextFormField(
                        style: inputFieldText,
                        controller: passController,
                        decoration: passField,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                        validator: (val) => val!.isEmpty
                            ? "Introduza a password"
                            : ((val.length < 6)
                                ? "A password deve conter pelo menos 6 caracteres!"
                                : null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0)),
                    onPressed: () async {
                      if (_signInForm.currentState!.validate()) {
                        final email = emailController.text.trim();
                        print(email);
                        final password = passController.text.trim();
                        print(password);

                        final context = this.context;
                        // Capture the context here

                        try {
                          final user = await _firebaseAuthService
                              .signInWithEmailAndPassword(
                            email,
                            password,
                            context,
                          );

                          logger.i("Success");
                          // Update SharedPreferences after successful login
                          var u = await UserManager.userLoggedIn(user!);

                          print(u);

                          var val = ref.refresh(userProvider);
                          print(val);
                          goToPageChecker();
                        } catch (e) {
                          // Handle authentication errors
                          _signInError = e.toString();
                          _firebaseSignInErrorAlert(context);
                          logger.e("Authentication error: $e");
                        }
                      } else {
                        logger.e("Unable to validate sign up form!!");
                      }
                    },
                    child: Text("Entrar",
                        // child: Text(_isSignIn ? "Entrar" : "Registar",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontSize: 20.0, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            // ElevatedButton(
            //     onPressed: () async {
            //       final signUpResult = await _firebaseAuthService.signOut();
            //     },
            //     child: const Text("Sign out")),
          ],
        ));
  }

  goToPageChecker() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserChecker()),
        (route) => false);
  }

  _firebaseSignInErrorAlert(BuildContext context) {
    final errMessageArray = _signInError;
    final title = Constants.signInMessageTranslator[errMessageArray];
    // final desc = errMessageArray[1];
    Alert(
      style: AlertStyle(
          overlayColor: spaceGray,
          animationType: AnimationType.grow,
          animationDuration: const Duration(milliseconds: 600)),
      context: context,
      title: title ?? "Algo correu mal",
      // desc: desc,
      image: const Icon(
        Icons.error_rounded,
        color: Color.fromARGB(255, 196, 56, 47),
        size: 60.0,
      ),
      buttons: [
        DialogButton(
          color: color2,
          child: const Text("Tente de novo"),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    ).show();
  }
}
