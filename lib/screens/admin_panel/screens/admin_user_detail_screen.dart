import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../models/user_model.dart';

class UserDetailedScreen extends StatefulWidget {
  String userId;
  UserModel userModel;

  UserDetailedScreen(
      {super.key, required this.userId, required this.userModel});

  @override
  State<UserDetailedScreen> createState() => _UserDetailedScreenState();
}

class _UserDetailedScreenState extends State<UserDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(.5),
              Colors.white.withOpacity(1),
              Colors.blue.withOpacity(.8),
            ],
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: Get.width / 1.1,
              height: Get.height / 1.8,
              child: Padding(
                padding: const EdgeInsets.only(),
                child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text(
                      widget.userModel.username[0],
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.userModel.username,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "UserName",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userModel.username,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent),
                            )
                          ]),

                      SizedBox(height: 10,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userModel.email,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  ),
                            )
                          ]),

                      SizedBox(height: 10,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "Phone",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userModel.phone,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                          ]),
                      SizedBox(height: 10,),

                      Row(mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              "City",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500,color: Colors.grey),
                            ),
                            Text(
                              " : ",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              widget.userModel.city,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ]),
                    ],
                  ),
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
