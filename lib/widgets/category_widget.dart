import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:signature_funiture_project/models/category_model.dart';
import 'package:signature_funiture_project/screens/user_panel/signale_category_product_screen.dart';

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
              height: Get.height / 9,
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
                            GestureDetector(
                              onTap: () => Get.to(() =>
                                  AllSingleCategoryProductScreen(
                                      categoryId: categoriesModel.categoryId)),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                // child: Container(
                                //   child: TransparentImageCard(
                                //     borderRadius: 10.0,
                                //     width: Get.width / 4.5,
                                //     imageProvider: CachedNetworkImageProvider(
                                //       categoriesModel.categoryImg,
                                //     ),
                                //     title: Padding(
                                //       padding: const EdgeInsets.only(left: 5),
                                //       child: Text(
                                //         categoriesModel.categoryName,
                                //         overflow: TextOverflow.ellipsis,
                                //         style: TextStyle(
                                //             fontSize: 15.0,
                                //             color: Colors.white),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.lightBlueAccent.withOpacity(0.3),
                                          Colors.white.withOpacity(0.3),
                                          Colors.lightBlueAccent.withOpacity(0.3),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 80,
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          width: 30,
                                          height: 30,
                                          image: NetworkImage(
                                              categoriesModel.categoryImg)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(categoriesModel.categoryName,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            );
          }
          return Container();
        });
  }
}
