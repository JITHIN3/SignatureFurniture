import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'package:signature_funiture_project/controllers/forget_password_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white,
          title: Text(
            "Forgot Password",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 250,
                      child: Image(
                        image: AssetImage("lib/assets/images/Forgot password.png"),
                      )),
                  Text(
                    "    Enter the email address\nassociated with your account.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We will email you a link to reset\n              your password",
                    style: TextStyle(color: Colors.grey),
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Material(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(15.0)),
                        width: Get.width / 1.1,
                        height: Get.height / 18,
                        child: TextButton(
                            onPressed: () async {
                              String email = userEmail.text.trim();

                              if (email.isEmpty) {
                                Get.snackbar("Error", "Please enter all details",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.pink,
                                    margin: EdgeInsets.all(20),
                                    colorText: Colors.white);
                              } else {
                                String email = userEmail.text.trim();
                                forgetPasswordController.ForgetPasswordMethod(email);
                              }
                            },
                            child: const Text(
                              "Send",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
