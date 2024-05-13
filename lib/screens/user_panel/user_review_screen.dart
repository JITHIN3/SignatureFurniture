import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../models/product_model.dart';

class UserReviewScreen extends StatefulWidget {
  UserReviewScreen(
      {super.key, required this.productModel, required this.productid});

  ProductModel productModel;
  String productid;

  @override
  State<UserReviewScreen> createState() => _UserReviewScreenState();
}

TextEditingController reviewcontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();

class _UserReviewScreenState extends State<UserReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.productModel.productImages[0],
                      ),
                    ),
                  ),
                ),
                Container(width: Get.width / 1.5,
                  child: Text(
                    widget.productModel.productName,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,overflow: TextOverflow.ellipsis),
                 maxLines: 4, ),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              controller: namecontroller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 200,
              decoration: BoxDecoration(),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Write your review",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: reviewcontroller,
                maxLines: 6,
              ),
            ),
          ),
          ElevatedButton(style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
            onPressed: () async {
              if (namecontroller.text != '' && reviewcontroller.text != '') {
                EasyLoading.show();
                CollectionReference collref =
                    FirebaseFirestore.instance.collection('reviews');
                await collref.add({
                  'userName': namecontroller.text,
                  'productId': widget.productModel.productId,
                  'productName': widget.productModel.productName,
                  'categoryId': widget.productModel.categoryId,
                  'categoryName': widget.productModel.categoryName,
                  'createdAt': widget.productModel.createdAt,
                  'updatedAt': widget.productModel.updatedAt,
                  'review': reviewcontroller.text
                });
                reviewcontroller.clear();
                namecontroller.clear();
              } else {
                print("Please fill all details");
                Get.snackbar("Warning!", "Please fill all details!",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    duration: Duration(seconds: 5),
                    snackPosition: SnackPosition.BOTTOM);
              }

              EasyLoading.dismiss();
            },
            child: Text("Submit",style: TextStyle(color: Colors.white,)),
          ),
        ]),
      ),
    );
  }
}
