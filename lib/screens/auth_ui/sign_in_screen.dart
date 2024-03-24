import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/sign_in_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/admin_main_screen.dart';
import 'package:signature_funiture_project/screens/auth_ui/forget_password_screen.dart';
import 'package:signature_funiture_project/screens/auth_ui/sign_up_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/main_screen.dart';

import '../../controllers/get_user_data_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          elevation: 0,
          title: Text(
            "Sign In",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      child: Image(
                        image: AssetImage("lib/assets/images/Login.png"),
                      )),
                  Container(height: 50,
                      margin: EdgeInsets.all(20),
                      child: TextFormField(
                        controller: userEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Obx(
                      () => Center(
                        child: TextFormField(
                          controller: userPassword,
                          obscureText: signInController.isPasswordVisible.value,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  signInController.isPasswordVisible.toggle();
                                },
                                child: signInController.isPasswordVisible.value
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off),
                              ),
                              prefixIcon: Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15)),
                        width: Get.width / 1.1,
                        height: Get.height / 18,
                        child: TextButton(
                            onPressed: () async {
                              String email = userEmail.text.trim();
                              String password = userPassword.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                Get.snackbar(
                                    margin: EdgeInsets.all(20),
                                    "Error",
                                    "Please enter all details",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.pink,
                                    colorText: Colors.white);
                              } else {
                                UserCredential? userCredential =
                                    await signInController.signInMethod(
                                        email, password);

                                var userData = await getUserDataController
                                    .getUserData(userCredential!.user!.uid);

                                if (userCredential != null) {
                                  if (userCredential.user!.emailVerified) {
                                    //
                                    if (userData[0]['isAdmin'] == true) {
                                      Get.offAll(() => AdminMainScreen());
                                      Get.snackbar(
                                          "Success Admin Login", "Login Successfully!",
                                          margin: EdgeInsets.all(20),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white);
                                    } else {

                                      Get.offAll(() => MainSCreen());
                                      Get.snackbar(
                                          "Success User Login", "Login Successfully!",
                                          margin: EdgeInsets.all(20),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.green,
                                          colorText: Colors.white);
                                    }


                                  } else {
                                    Get.snackbar("Error",
                                        "Please verify your email before login!",
                                        margin: EdgeInsets.all(20),
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white);
                                  }
                                } else {
                                  Get.snackbar("Error", "Please try again",
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: EdgeInsets.all(20),
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white);
                                }
                              }
                            },
                            child: Text(
                              "Sign in",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have an account? ",
                          style: TextStyle(fontSize: 15)),
                      GestureDetector(
                          onTap: () {
                            Get.off(() => SignUpScreen());
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
