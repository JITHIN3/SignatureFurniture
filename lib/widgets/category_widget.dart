import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:signature_funiture_project/models/category_model.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('category').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 6,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No category found!"),
            );
          }
          if (snapshot.data != null) {
            return Container(
              height: Get.height /5,
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoriesModel categoriesModel = CategoriesModel(
                        categoryId: snapshot.data!.docs[index]['categoryId'],
                        categoryImg: snapshot.data!.docs[index]['categoryImg'],
                        categoryName: snapshot.data!.docs[index]
                            ['categoryName'],
                        createdAt: snapshot.data!.docs[index]['createdAt'],
                        updatedAt: snapshot.data!.docs[index]['updatedAt']);
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Card(

                                child: Container(
                                  height: 100,
                                  width: 80,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Colors.white, Colors.lightBlueAccent],
                                          begin: const FractionalOffset(0, .8),
                                          end: const FractionalOffset(1, 1.3),
                                          stops: [0.0,3.0],
                                          tileMode: TileMode.clamp
                                      ),
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black54,
                                        blurRadius: 10.0, // soften the shadow
                                        spreadRadius: 1.0, //extend the shadow

                    )]
                                  ),
                                child: Center(child: Image(image: NetworkImage(categoriesModel.categoryImg,),width: 70,),),),
                                elevation: 0,
                                color: Colors.grey.shade50,
                                clipBehavior: Clip.hardEdge,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(categoriesModel.categoryName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),)
                      ],
                    );
                  }),
            );
          }
          return Container();
        });
  }
}
