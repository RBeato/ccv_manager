import 'package:ccv_manager/authentication/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../styles/colors/colors.dart';
import '../../styles/input_fields.dart';
import '../../../home_page/landing_page/user_checker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen(
      {Key? key, required this.title, required this.toggleAuthScreen})
      : super(key: key);
  final String title;
  final Function toggleAuthScreen;

  @override
  State<SignUpScreen> createState() => _SignUpScrensState();
}

class _SignUpScrensState extends State<SignUpScreen> {
  var logger = Logger();
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final _signUpForm = GlobalKey<FormState>();
  String email = "null";
  String pass = "null";
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String _signInError = "";

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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              "Fazer Registo",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: Form(
                key: _signUpForm,
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
                            ? "Introduza o email"
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
                                ? "A password deve conter pelo menos 6 caractéres!"
                                : null),
                      ),
                    )
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
                        if (_signUpForm.currentState!.validate()) {
                          dynamic signUpResult = await _firebaseAuthService
                              .signUpWithEmailAndPassword(email, pass, context);

                          if (signUpResult != null &&
                              !signUpResult
                                  .toString()
                                  .contains("AuthException:")) {
                            logger.i("Sucesso");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserChecker()),
                                (route) => false);
                          } else {
                            _signInError = signUpResult.toString();
                            _firebaseSignInErrorAlert(context);
                            logger.e(signUpResult.toString());
                          }
                        } else {
                          logger.e("Unable to validate sign up form!!");
                        }
                      },
                      child: Text("Fazer Registo",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(fontSize: 20.0, color: Colors.white))),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Já criou conta?",
                    style: Theme.of(context).textTheme.bodyMedium),
                TextButton(
                    onPressed: () async {
                      widget.toggleAuthScreen();
                    },
                    child: Text(
                      "Entrar",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 20.0),
                    ))
              ],
            )
          ],
        ));
  }

  _firebaseSignInErrorAlert(BuildContext context) {
    final errMessageArray = _signInError.split(' ');
    final title = errMessageArray[0];
    final desc = errMessageArray[1];
    Alert(
        style: AlertStyle(
            overlayColor: spaceGray,
            animationType: AnimationType.grow,
            animationDuration: const Duration(milliseconds: 600)),
        context: context,
        title: title,
        desc: desc,
        image: const Icon(
          Icons.error_rounded,
          color: Colors.red,
          size: 60.0,
        ),
        buttons: [
          DialogButton(
            color: color2,
            child: const Text("Tentar de novo"),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
        content: Container(
          padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 0.0),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "Já tem uma conta? ",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0)),
                  onPressed: () {
                    widget.toggleAuthScreen();
                    Navigator.pop(context, false);
                  },
                  child: const Text("Entrar agora"))
            ],
          ),
        )).show();
  }
}
