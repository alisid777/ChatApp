import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:usertouserchat/pages/homepage.dart';
import 'package:usertouserchat/pages/loginpage.dart';

class AuthServices extends GetxController {
  //instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //sign in

  void signIn(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null) {
        Get.offAll(const HomePage());
      }
    } catch (e) {
      print('Error in SignIn service $e');
      Get.snackbar('Error', 'Error in sign in service');
    }
  }

  // sign up
  void signUp(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      if (user != null) {
        await firestore.collection('users').doc(user.uid).set({
          "email": email,
          "id": user.uid,
        });
        Get.offAll(() => const HomePage());
      }
    } catch (e) {
      print('Error in SignUp service $e');
      Get.snackbar('Error', 'Error in sign up service');
    }
  }

  //sign out

  void signOut() async {
    await _auth.signOut();
    Get.offAll(const LoginPage());
  }
}
