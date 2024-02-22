import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/sign_up_controller.dart';
import 'package:signature_funiture_project/screens/auth_ui/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController username = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.all(10),
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
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: username,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: userPhone,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Phone",
                          prefixIcon: Icon(Icons.phone_android_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: userCity,
                      decoration: InputDecoration(
                          hintText: "City",
                          prefixIcon: Icon(Icons.location_city),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Obx(
                    () => TextFormField(
                      obscureText: signUpController.isPasswordVisible.value,
                      controller: userPassword,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                              onTap: () {
                                signUpController.isPasswordVisible.toggle();
                              },
                              child: signUpController.isPasswordVisible.value
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility)),
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
                            String name = username.text.trim();
                            String email = userEmail.text.trim();
                            String phone = userPhone.text.trim();
                            String city = userCity.text.trim();
                            String password = userPassword.text.trim();
                            String userDeviceToken = '';

                            if (name.isEmpty ||
                                email.isEmpty ||
                                phone.isEmpty ||
                                password.isEmpty) {
                              Get.snackbar("Error", "Please Enter all Details",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.blue,
                                  colorText: Colors.white);
                            } else {
                              UserCredential? userCredential =
                                  await signUpController.signUpMethod(
                                      name,
                                      email,
                                      phone,
                                      city,
                                      password,
                                      userDeviceToken);

                              if (userCredential != null) {
                                Get.snackbar("Verification email sent ",
                                    "Please check your email",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.blue,
                                    colorText: Colors.white);

                                FirebaseAuth.instance.signOut();
                                Get.offAll(() => SignInScreen());
                              }
                            }
                          },
                          child: Text(
                            "Sign Up",
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
                    Text("Already have an account?"),
                    GestureDetector(
                        onTap: () {
                          Get.off(() => SignInScreen());
                        },
                        child: Text("Sign In"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
