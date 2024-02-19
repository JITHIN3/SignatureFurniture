import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:signature_funiture_project/screens/auth_ui/welcome_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/main_screen.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Get.offAll(()=>WelcomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            Expanded(
              child: Container(height: 100,width: 100,
                child: Image(image: AssetImage("lib/assets/images/instagram.png"))
              ),
            ),
            Container(margin: EdgeInsets.only(bottom: 20),alignment: Alignment.center,width: Get.width,child:Text("Welcome"))
          ]),
        ),
      ),
    );
  }
}
