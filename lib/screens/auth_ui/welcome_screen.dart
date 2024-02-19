import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Siganture Funiture"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Material(
            child: Center(
              child: Container(decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20.0)),
                width: Get.width / 1.2,
                height: Get.height / 12,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      "lib/assets/images/google-symbol.png",
                      width: Get.width / 12,
                      height: Get.height / 12,
                    ),
                    label: Text("Sign in with google")),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Material(
            child: Container(decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(20.0)),
              width: Get.width / 1.2,
              height: Get.height / 12,
              child: TextButton.icon(
                  onPressed: () {},
                  icon:Icon(Icons.email_outlined),
                  label: Text("Sign in with google")),
            ),
          )
        ]),
      ),
    );
  }
}
