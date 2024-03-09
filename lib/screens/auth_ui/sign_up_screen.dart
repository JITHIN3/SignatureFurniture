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
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        leading: GestureDetector(onTap: (){
          Navigator.pop(context);
        },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        title: Text("Sign Up",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 200,
                      child: Image(
                        image: AssetImage("lib/assets/images/SignUp.png"),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: TextFormField(
                        controller: userEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            hintText: "Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: TextFormField(
                        controller: username,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            hintText: "Username",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: TextFormField(
                        controller: userPhone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            hintText: "Phone",
                            prefixIcon: Icon(Icons.phone_android_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: TextFormField(
                        controller: userCity,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            hintText: "City",
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 10),
                    child: Obx(
                      () => TextFormField(
                        obscureText: signUpController.isPasswordVisible.value,
                        controller: userPassword,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            hintText: "Password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  signUpController.isPasswordVisible.toggle();
                                },
                                child: signUpController.isPasswordVisible.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
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
                            borderRadius: BorderRadius.circular(15.0)),
                        width: Get.width / 1.1,
                        height: Get.height / 15,
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
                                Get.snackbar(
                                    "Error", "Please Enter all Details",
                                    snackPosition: SnackPosition.BOTTOM,
                                    margin: EdgeInsets.all(20),

                                    backgroundColor: Colors.pink,
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
                                      backgroundColor: Colors.pink,
                                      margin: EdgeInsets.all(20),
                                      colorText: Colors.white);

                                  FirebaseAuth.instance.signOut();
                                  Get.offAll(() => SignInScreen());
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
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
                      Text("Already have an account?", style: TextStyle(fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Get.off(() => SignInScreen());
                        },
                        child: Text(
                          " Sign In",
                          style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
