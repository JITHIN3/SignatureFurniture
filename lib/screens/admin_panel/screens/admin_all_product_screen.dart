// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/admin_category_dropdown_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/is_sale_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_add_product_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_edit_product_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_product_detail_screen.dart';

class AdminAllProductsScreen extends StatefulWidget {
  const AdminAllProductsScreen({super.key});

  @override
  State<AdminAllProductsScreen> createState() => _AdminAllProductsScreenState();
}


Future<void> _handleRefresh() async {
  return await Future.delayed(Duration(seconds: 2));

}


class _AdminAllProductsScreenState extends State<AdminAllProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Products"),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => AdminAddPrdouctScreen()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: LiquidPullToRefresh(onRefresh: _handleRefresh,color: Colors.blueAccent,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('products')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Error occurred while fetching products!'),
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
                  child: Text('No products found!'),
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

                  ProductModel productModel = ProductModel(
                    productId: data['productId'],
                    categoryId: data['categoryId'],
                    productName: data['productName'],
                    categoryName: data['categoryName'],
                    salePrice: data['salePrice'],
                    fullPrice: data['fullPrice'],
                    productImages: data['productImages'],
                    deliveryTime: data['deliveryTime'],
                    isSale: data['isSale'],
                    productDescription: data['productDescription'],
                    createdAt: data['createdAt'],
                    updatedAt: data['updatedAt'],
                  );

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AdminSingleProductDetailScreen(
                              productModel: productModel));
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Image.network(
                                      productModel.productImages[0]),
                                  width: 120,
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
                                        productModel.productName,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      "Product Id : " + productModel.productId,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    ),
                                    Text(
                                      "Category : " + productModel.categoryName,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                    Text(
                                      "Category Id : " + productModel.categoryId,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final editProductCategory =
                                      Get.put(CategoryDropDownController());
                                  final isSaleController =
                                      Get.put(IsSaleController());
                                  editProductCategory
                                      .setOldValue(productModel.categoryId);
                                  isSaleController
                                      .setIsSaleOldValue(productModel.isSale);

                                  Get.to(() => EditProductScreen(
                                      productModel: productModel));
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.redAccent),
                                ),
                              )
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

                  // return Card(
                  //   elevation: 5,
                  //   child: ListTile(
                  //     onTap: () {
                  //       Get.to(() => AdminSingleProductDetailScreen(productModel: productModel));
                  //     },
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.blueAccent,
                  //       backgroundImage: CachedNetworkImageProvider(
                  //         productModel.productImages[0],
                  //         errorListener: (err) {
                  //           // Handle the error here
                  //           print('Error loading image');
                  //           Icon(Icons.error);
                  //         },
                  //       ),
                  //     ),
                  //     title: Text(productModel.productName),
                  //     subtitle: Text(productModel.productId),
                  //     trailing: Icon(Icons.arrow_forward_ios),
                  //   ),
                  // );
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
