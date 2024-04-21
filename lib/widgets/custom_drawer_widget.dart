import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature_funiture_project/models/user_model.dart';
import 'package:signature_funiture_project/screens/user_panel/all_order_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/all_product_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/contact_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/main_screen.dart';

import '../screens/auth_ui/welcome_screen.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key, UserModel? userModel});


  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot> (
      future: users.doc(user!.uid).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return   Padding(
            padding: EdgeInsets.only(top: Get.height / 25),
            child: Drawer(backgroundColor: Colors.white,
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
                      title: Text("${data['username'].toString()}"),
                      subtitle: Text("${data['email'].toString()}"),
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.blueAccent,
                        child: Text("${data['username'][0].toString()}"),
                      ),
                    ),
                  ),
                  Divider(thickness: 5,

                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: GestureDetector(onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainSCreen()));
                    },
                      child: Container(height: 30,
                        child: Center(
                          child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text("Home"),


                              leading:Icon(Icons.home)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: GestureDetector(onTap: () => Get.to(() => AllProductScreen()),
                      child: Container(height: 30,
                        child: Center(
                          child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text("Product"),


                              leading:Icon(Icons.production_quantity_limits)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: Container(height: 30,
                      child: ListTile(onTap: (){
                        Get.back();
                        // Get.to(()=>AllOrderScreen());
                        Get.to(()=>AllOrdersScreen());
                      },
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text("Order"),


                          leading:Icon(Icons.shopping_cart)
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: Container(height: 30,
                      child: ListTile(onTap: (){
                        Get.back();
                        Get.to(()=>ContactScreen());

                      },
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text("Contact"),


                          leading:Icon(Icons.contact_phone_rounded)
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10),
                    child: Container(height: 30,
                      child: ListTile(
                          onTap: () async{
                            GoogleSignIn googleSignIn = GoogleSignIn();
                            FirebaseAuth _auth = FirebaseAuth.instance;
                            await _auth.signOut();
                            await googleSignIn.signOut();
                            Get.offAll(()=>WelcomeScreen());
                          },
                          titleAlignment: ListTileTitleAlignment.center,
                          title: Text("Logout",style: TextStyle(color: Colors.redAccent),),


                          leading:Icon(Icons.logout,color: Colors.redAccent)
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        }
        return Container();
      }),
    );



  }
}
