import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
                Container(
                    margin: EdgeInsets.all(20),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword
                      ,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(Icons.visibility_off),
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    )),
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
                          onPressed: () {

                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Text("Dont have an account?"),
                  Text("Sign Up")
                ],)
              ],
            ),
          ),
        ),
      );
    });
  }
}
