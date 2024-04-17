// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:signature_funiture_project/models/category_model.dart';
import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/screens/user_panel/product_details_screen.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(
          "All Products",
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('isSale', isEqualTo: false)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No product found!"),
            );
          }

          if (snapshot.data != null) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.77,
              ),
              itemBuilder: (context, index) {
                final productData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                    productId: productData['productId'],
                    categoryId: productData['categoryId'],
                    productName: productData['productName'],
                    categoryName: productData['categoryName'],
                    salePrice: productData['salePrice'],
                    fullPrice: productData['fullPrice'],
                    productImages: productData['productImages'],
                    deliveryTime: productData['deliveryTime'],
                    isSale: productData['isSale'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt']);

                // CategoriesModel categoriesModel = CategoriesModel(
                //   categoryId: snapshot.data!.docs[index]['categoryId'],
                //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                //   categoryName: snapshot.data!.docs[index]['categoryName'],
                //   createdAt: snapshot.data!.docs[index]['createdAt'],
                //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                // );
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () => Get.to(() => ProductDetailsScreen(
                            productModel: productModel,
                            productid: productModel.productId,
                          )),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Get.height / 6,
                              width: Get.width / 2.7,
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      productModel.productImages[0])),
                            ),
                            SizedBox(
                              height: 3,
                            ),

                            Text(
                              productModel.productName,
                              maxLines: 1,
                              style: TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 18,
                              width: 35,
                              child: Center(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          productModel.categoryName,
                                          style: TextStyle(
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),

                            Row(
                              children: [
                                productModel.isSale == true &&
                                    productModel.salePrice != ''
                                    ? Text(
                                  "₹" + productModel.salePrice,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                                    : Text(
                                  "₹" + productModel.fullPrice,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                productModel.isSale == true &&
                                    productModel.fullPrice !=
                                        productModel.salePrice
                                    ? Text(
                                  "₹" + productModel.fullPrice,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey),
                                )
                                    : Container()
                              ],
                            ),
                            Text("Free delivery",
                                style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ),
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
