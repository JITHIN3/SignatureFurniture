import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/sign_in_controller.dart';
import 'package:signature_funiture_project/screens/auth_ui/sign_up_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                Container(
                  margin: EdgeInsets.all(20),
                  child: Obx(
                    () => TextFormField(
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
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Text("Forgotpassord?"),
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20.0)),
                      width: Get.width / 1.2,
                      height: Get.height / 12,
                      child: TextButton(
                          onPressed: () async {
                            String email = userEmail.text.trim();
                            String password = userPassword.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              Get.snackbar("Error", "Please enter all details");
                            } else {
                              UserCredential? userCredential =
                                  await signInController.signInMethod(
                                      email, password);

                              if (userCredential != null) {
                                if (userCredential.user!.emailVerified) {
                                  Get.snackbar("Success", "Login Successfully!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.green,
                                      colorText: Colors.white);

                                  Get.offAll(()=>MainSCreen());
                                } else {
                                  Get.snackbar("Error",
                                      "Please verify your email before login!",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.redAccent,
                                      colorText: Colors.white);
                                }
                              }
                              else{
                                Get.snackbar("Error",
                                    "Please try again",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.redAccent,
                                    colorText: Colors.white);
                              }
                            }
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                    Text("Dont have an account?"),
                    GestureDetector(
                        onTap: () {
                          Get.offAll(() => SignUpScreen());
                        },
                        child: Text("Sign Up"))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
