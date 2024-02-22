// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/screens/auth_ui/sign_in_screen.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> ForgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait..");
      await _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
          "Request Sent Successfully", "Password reset link sent to $userEmail",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.blue,
          colorText: Colors.white);
      Get.offAll(()=>const SignInScreen());


      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }
}
