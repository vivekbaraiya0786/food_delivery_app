
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';


class SignInResponse {
  final dynamic user;
  final String? msg;

  SignInResponse({this.user, this.msg});
}

class FirebaseAuthHelper {
  FirebaseAuthHelper._();
  static final FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn googleSignIn = GoogleSignIn();


  //todo:signOut

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  Future<SignInResponse> signInAnonymously() async {
    SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth.signInAnonymously();
      User? user = userCredential.user;

      signInResponse = SignInResponse(user: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }



  Future<SignInResponse> signinWithEmailPassword(
      {required String email, required String password}) async {
    SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      signInResponse = SignInResponse(user: user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        case "wrong-password":
          signInResponse = SignInResponse(msg: "Password is wrong");
          break;
        case "user-not-found":
          signInResponse = SignInResponse(msg: "User does not exists with this email id");
          break;
        case "user-disabled":
          signInResponse = SignInResponse(msg: "User is disabled ,contact admin");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }



  Future<SignInResponse> signupWithEmailPassword({required String email, required String password}) async {
    SignInResponse signInResponse;

    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      signInResponse= SignInResponse(user: user);


    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg:"This service temporary down" );
        case "weak-password":
          signInResponse = SignInResponse(msg: "Password must be grater than 6 char.");
        case "email-already-in-use":
          signInResponse = SignInResponse(msg: "User with this email id is already exists");
        default:
          signInResponse = SignInResponse(msg: e.code);
      }
    }
    return signInResponse;
  }



//todo:signInWithGoogle
  Future<SignInResponse> signInWithGoogle() async {
    SignInResponse signInResponse;

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      signInResponse = SignInResponse(user: user);



    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          signInResponse = SignInResponse(msg: "This service temporary down");
          break;
        default:
          signInResponse = SignInResponse(msg: e.code);
          break;
      }
    }
    return signInResponse;
  }


}



