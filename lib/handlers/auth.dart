import 'package:firebase_auth/firebase_auth.dart';

import '../handlers/user_data.dart';

class AuthHandler {
  FirebaseUser user;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  checkIfLogged() async {
    if (user != null) {
      userData.userId = user.uid;
    } else {
      await signInAnon();
    }
  }

  signInAnon() async {
    user = await firebaseAuth.signInAnonymously();
    userData.userId = user.uid;
  }
}

AuthHandler authHandler = new AuthHandler();
