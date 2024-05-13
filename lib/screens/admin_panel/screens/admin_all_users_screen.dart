import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/get_all_user_length_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_user_detail_screen.dart';

import '../../../models/user_model.dart';
class AdminAllUsersScreen extends StatefulWidget {
  const AdminAllUsersScreen({super.key});

  @override
  State<AdminAllUsersScreen> createState() => _AdminAllUsersScreenState();
}

class _AdminAllUsersScreenState extends State<AdminAllUsersScreen> {

  final GetUserLengthController _getUserLengthController = Get.put(GetUserLengthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        title:Obx((){
          return Text('Users (${_getUserLengthController.userCollectionLength.toString()})');
        })

      ),
      body: Container(width: Get.width,
        height: Get.height,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(1),
              Colors.white.withOpacity(1),
              Colors.blue.withOpacity(.8),
            ],
          ),
        ),
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .orderBy('createdOn', descending: true).where("Isadmin" == false)
              .get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Error occurred while fetching category!'),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Container(
                child: Center(
                  child: Text('No users found!'),
                ),
              );
            }

            if (snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data!.docs[index];

                  UserModel userModel = UserModel(
                    city:data['city'] ,
                    uId: data['uId'],
                    username: data['username'],
                    email: data['email'],
                    phone: data['phone'],
                    userImg: data['userImg'],
                    userDeviceToken: data['userDeviceToken'],
                    country: data['country'],
                    userAddress: data['userAddress'],
                    street: data['street'],
                    isAdmin: data['isAdmin'],
                    isActive: data['isActive'],
                    createdOn: data['createdOn'],
                  );

                  return Card(
                    elevation: 5,
                    child: ListTile(tileColor: Colors.white,
                      onTap: () => Get.to(
                        () => UserDetailedScreen(
                            userId: snapshot.data!.docs[index].id,
                            userModel: userModel),
                      ),

                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                      child: Text(userModel.username[0],style: TextStyle(fontSize: 18),),
                      ),
                      title: Text(userModel.username),
                      subtitle: Text(userModel.email),
                      trailing: GestureDetector(onTap: (){
                        // FirebaseFirestore.instance.collection('users').doc().delete();
                      },child: Icon(Icons.delete,color: Colors.redAccent,)),
                    ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
