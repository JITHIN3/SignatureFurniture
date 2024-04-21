import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          child: Center(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: 300,
                  child: Image(
                    image: AssetImage("lib/assets/images/Contact us-amico.png"),
                  )),
              Text(
                "Contact Us",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'signaturefuniture@gmail.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  '+91 8943123280',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Material(
              //   child: Center(
              //     child: Container(
              //       decoration: BoxDecoration(
              //           boxShadow: [
              //             new BoxShadow(
              //               color: Colors.black,
              //               blurRadius: 1,
              //             ),
              //           ],
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10.0)),
              //       width: Get.width / 1.2,
              //       height: Get.height / 18,
              //       child: TextButton.icon(
              //           onPressed: () {
              //
              //           },
              //           icon: Image.asset(
              //             "lib/assets/images/google-symbol.png",
              //             width: Get.width / 12,
              //             height: Get.height / 18,
              //           ),
              //           label: Text("Sign in with google")),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Material(
              //   child: Container(
              //     decoration: BoxDecoration(
              //         boxShadow: [
              //           new BoxShadow(
              //             color: Colors.black,
              //             blurRadius: 1,
              //           ),
              //         ],
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10.0)),
              //     width: Get.width / 1.2,
              //     height: Get.height / 18,
              //     child: TextButton.icon(
              //         onPressed: () {
              //
              //         },
              //         icon: Icon(Icons.email_outlined),
              //         label: Text("Sign in with Email")),
              //   ),
              // ),
            ]),
          ),
        ),
      ),
    );
  }
}
