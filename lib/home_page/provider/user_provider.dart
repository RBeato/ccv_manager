import 'package:ccv_manager/models/ccv_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/user_manager.dart';

final userProvider = FutureProvider<CCVUser?>((ref) async {
  bool isLogged = await UserManager.checkUserState();
  if (isLogged) {
    CCVUser user = await UserManager.getUser();
    debugPrint("userProvider: $user");
    return user;
  }
  print("Is Logged: $isLogged");
  return null;
});

// final userProvider = FutureProvider<CCVUser?>((ref) async {
//   return CCVUser(
//       name: "Romeu Beato",
//       email: "romeu.beato@cm-vinhais.pt",
//       id: "46iVx0sSU1ZFykGgmLjdyUSoACf1",
//       role: "admin");
// });
