import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature_funiture_project/screens/user_panel/all_order_screen.dart';

import '../screens/auth_ui/welcome_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("JITHIN"),
                subtitle: Text("version 1.0.1"),
                leading: CircleAvatar(
                  radius: 22.0,
                  backgroundColor: Colors.blueAccent,
                  child: Text("W"),
                ),
              ),
            ),
            Divider(
              indent: 10.0,
              endIndent: 10.0,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text("Home"),
                trailing: Icon(Icons.arrow_forward_rounded),

                leading:Icon(Icons.home)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Product"),
                  trailing: Icon(Icons.arrow_forward_rounded),

                  leading:Icon(Icons.production_quantity_limits)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(onTap: (){
                Get.back();
                // Get.to(()=>AllOrderScreen());
                Get.to(()=>AllOrdersScreen());
              },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Order"),
                  trailing: Icon(Icons.arrow_forward_rounded),

                  leading:Icon(Icons.shopping_cart)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Contact"),
                  trailing: Icon(Icons.arrow_forward_rounded),

                  leading:Icon(Icons.help)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                onTap: () async{
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth _auth = FirebaseAuth.instance;
                  await _auth.signOut();
                  await googleSignIn.signOut();
                  Get.offAll(()=>WelcomeScreen());
                },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Logout"),
                  trailing: Icon(Icons.arrow_forward_rounded),

                  leading:Icon(Icons.logout)
              ),
            ),

          ],
        ),
      ),
    );
  }
}
