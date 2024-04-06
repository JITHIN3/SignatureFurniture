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

class AllProductWidget extends StatelessWidget {

   AllProductWidget({super.key});



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
          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: .70,
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
              return Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.to(
                        () => ProductDetailsScreen(productModel: productModel,productid: productModel.productId,)),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      // child: Container(
                      //   child: FillImageCard(
                      //     borderRadius: 20.0,
                      //     width: Get.width / 2.3,
                      //     heightImage: Get.height / 6,
                      //     imageProvider: CachedNetworkImageProvider(
                      //       productModel.productImages[0],
                      //     ),
                      //     title: Center(
                      //       child: Text(
                      //         productModel.productName,maxLines: 1,
                      //         style: TextStyle(fontSize: 12.0,overflow: TextOverflow.ellipsis),
                      //       ),
                      //     ),
                      //     footer: Center(child: Text("PKR: "+  productModel.fullPrice)),
                      //   ),
                      // ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Container(height: Get.height /6 ,width: Get.width / 2.7,
                        child: Image(fit: BoxFit.cover,
                          image:
                              NetworkImage(productModel.productImages[0])
                        ),
                      ),
                          SizedBox(height: 3,),
                          Text(productModel.productName,maxLines: 1,style: TextStyle(fontSize: 15),),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                BorderRadius.circular(5)),
                            height: 20,
                            width: 40,
                            child: Center(
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(productModel.categoryName,style: TextStyle(overflow: TextOverflow.ellipsis,color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),

                                  ]),
                            ),
                          ),

                          SizedBox(height: 3,),


                          Row(
                            children: [
                              Text("Rs "+productModel.salePrice,style:TextStyle(fontSize: 14),overflow: TextOverflow.ellipsis,),
                              SizedBox(width: 5,),
                              Text("Rs "+productModel.fullPrice,style:TextStyle(overflow: TextOverflow.ellipsis,fontSize: 12,color: Colors.grey,decoration: TextDecoration.lineThrough)),
                            ],
                          ),
                          Text("Free delivery",style:TextStyle(fontSize: 12),overflow: TextOverflow.ellipsis,),

                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
