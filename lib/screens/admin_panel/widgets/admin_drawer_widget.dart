import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature_funiture_project/screens/admin_panel/admin_main_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_order_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_product_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_users_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/all_order_screen.dart';

import '../../auth_ui/welcome_screen.dart';


class AdminDrawerWidget extends StatefulWidget {
  const AdminDrawerWidget({super.key});

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
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
                title: Text("Admin"),
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
              child: ListTile(onTap: (){
                Get.offAll(()=>AdminMainScreen());
              },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Home"),


                  leading:Icon(Icons.home)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(onTap: (){
                Get.to(()=>AdminAllUsersScreen());
              },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Users"),


                  leading:Icon(Icons.person)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(onTap: (){
                Get.to(()=>AdminAllOrdersScreen());
              },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Oders"),


                  leading:Icon(Icons.shopping_cart)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                onTap: (){
                  Get.back();
                  Get.to(()=>AdminAllProductsScreen());
                },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Product"),


                  leading:Icon(Icons.production_quantity_limits)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(onTap: (){
                // Get.back();
                // Get.to(()=>AllOrderScreen());
              },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Categories"),


                  leading:Icon(Icons.category)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Contact"),


                  leading:Icon(Icons.phone)
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: ListTile(onTap: () async{
                GoogleSignIn googleSignIn = GoogleSignIn();
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
                await googleSignIn.signOut();
                Get.offAll(()=>WelcomeScreen());
              },

                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text("Logout"),


                  leading:Icon(Icons.login)
              ),
            ),

          ],
        ),
      ),
    );
  }
}
