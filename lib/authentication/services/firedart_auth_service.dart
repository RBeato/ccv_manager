// // import 'package:firedart/auth/user_gateway.dart';
// // import 'package:firedart/firedart.dart';

// import 'package:logger/logger.dart';
// import '../../services/user_manager.dart';

// class FirebaseAuthService {
//   var logger = Logger();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future signInState() async {
//     // !Check Sign In State
//     return _firebaseAuth.isSignedIn;
//   }

//   Future currentUser() async {
//     //! Get Current User
//     User user = await _firebaseAuth.getUser();
//     // String localId = user.id;
//     // String? email = user.email;
//     return user;
//   }

//   Future signUp(String email, String pass) async {
//     try {
//       return await _firebaseAuth.signUp(email, pass);
//     } catch (e) {
//       logger.e(e.toString());
//       return e.toString();
//     }
//   }

//   Future signIn(String email, String pass) async {
//     try {
//       return await _firebaseAuth.signIn(email, pass);
//     } catch (e) {
//       logger.e(e.toString());
//       return e.toString();
//     }
//   }

//   Future signOut() async {
//     UserManager.logoutUser();
//     return _firebaseAuth.signOut();
//   }
// }
