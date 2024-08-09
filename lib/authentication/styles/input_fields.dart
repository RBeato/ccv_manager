import 'package:flutter/material.dart';

import 'colors/colors.dart';

// import '../../styles/colors/colors.dart';

var inputFieldContainer = BoxDecoration(
  color: inputFieldBack,
  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  border: Border.all(width: 1.0, color: inputFieldBorder),
);

var emailField = InputDecoration(
    border: InputBorder.none,
    hintText: "Email",
    labelText: "Email *",
    labelStyle: TextStyle(color: Colors.teal[200]),
    suffixIcon: Icon(
      Icons.email_rounded,
      color: iconColor,
      size: 30.0,
    ));

var passField = InputDecoration(
    border: InputBorder.none,
    labelText: "Password *",
    labelStyle: TextStyle(color: Colors.teal[200]),
    suffixIcon: Icon(
      Icons.password_rounded,
      color: iconColor,
      size: 30.0,
    ));

var inputFieldText = TextStyle(
    fontSize: 16.0, color: inputFieldTextColor, fontWeight: FontWeight.w600);
