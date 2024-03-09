import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:signature_funiture_project/controllers/get_user_data_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/admin_main_screen.dart';
import 'package:signature_funiture_project/screens/auth_ui/welcome_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/main_screen.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      loggedin(context);
    });
  }

  Future<void> loggedin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => AdminMainScreen());
      } else {
        Get.offAll(() => MainSCreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
              child: Image(
                  image: AssetImage("lib/assets/images/signature_logo.png"),width:300,height: 200,),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                width: Get.width,
                child: Text("Welcome"))
          ]),
        ),
      ),
    );
  }
}
