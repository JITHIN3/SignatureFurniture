import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/models/category_model.dart';

import '../../../models/product_model.dart';
import '../controller/admin_category_dropdown_controller.dart';
import '../controller/is_sale_controller.dart';
import 'admin_edit_product_screen.dart';
import 'admin_product_detail_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen.AdminAllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('category')
            // .orderBy('createdAt', descending: true)
            .snapshots(),
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
                child: Text('No category found!'),
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

                CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: data['categoryId'],
                    categoryImg: data['categoryImg'],
                    categoryName: data['categoryName'],
                    createdAt: data['createdAt'],
                    updatedAt: data['updatedAt']);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Image.network(
                                    categoriesModel.categoryImg),
                                width: 40,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width / 1.9,
                                    child: Text(
                                      categoriesModel.categoryName,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),

                                  Text(
                                    "Category Id : " + categoriesModel.categoryId,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            // GestureDetector(
                            //   onTap: () {},
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(right: 10),
                            //     child: Text(
                            //       "Edit",
                            //       style: TextStyle(
                            //           fontSize: 13,
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.redAccent),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(
                        thickness: 3,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
