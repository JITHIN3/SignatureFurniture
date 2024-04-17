// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:signature_funiture_project/models/category_model.dart';
import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';

import '../screens/user_panel/product_details_screen.dart';

class FlashSaleWidget extends StatelessWidget {
  const FlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: true)
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
          return Container(
            height: Get.height / 4.5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
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
                return Row(
                  children: [
                    GestureDetector(onTap:()=>Get.to(()=>ProductDetailsScreen(productModel:productModel,productid: productModel.productId,)),
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Container(
                          child: FillImageCard(color: Colors.grey.shade100,
                            borderRadius: 10.0,
                            width: Get.width / 3.2,
                            heightImage: Get.height / 8,
                            imageProvider: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            ),
                            title: Text(
                              productModel.productName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10.0),
                            ),
                            footer: Row(children: [
                              Text("Rs ${productModel.salePrice}",
                                  style: TextStyle(fontSize: 10.0),overflow: TextOverflow.ellipsis,),
                              SizedBox(width: 3.0,),
                              Text("Rs ${productModel.fullPrice}",
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: AppConstant.appScendoryColor,
                                      decoration: TextDecoration.lineThrough),overflow: TextOverflow.ellipsis,)
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
