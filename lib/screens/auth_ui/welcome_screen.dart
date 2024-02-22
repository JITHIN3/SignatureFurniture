import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/controllers/google_signin_controller.dart';
import 'package:signature_funiture_project/screens/auth_ui/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Siganture Funiture"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 300,
                child: Image(
                  image: AssetImage("lib/assets/images/Hello.png"),
                )),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ready to start shopping Sign Up\n                 to get Start',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  width: Get.width / 1.2,
                  height: Get.height / 18,
                  child: TextButton.icon(
                      onPressed: () {
                        _googleSignInController.signInWithGoogle();
                      },
                      icon: Image.asset(
                        "lib/assets/images/google-symbol.png",
                        width: Get.width / 12,
                        height: Get.height / 18,
                      ),
                      label: Text("Sign in with google")),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Material(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                width: Get.width / 1.2,
                height: Get.height / 18,
                child: TextButton.icon(
                    onPressed: () {
                      Get.to(() => SignInScreen());
                    },
                    icon: Icon(Icons.email_outlined),
                    label: Text("Sign in with Email")),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
