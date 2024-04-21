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

import 'cart_screen.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

var searchName = "";
TextEditingController searchcontroller = TextEditingController();

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        toolbarHeight: 120,
        actions: [
          Flexible(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30, bottom: 20,left: 30),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Products",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                            GestureDetector(
                              onTap: () => Get.to(() => CartScreen()),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Container(
                      child: TextFormField(
                        controller: searchcontroller,
                        onChanged: (value) {
                          setState(() {
                            searchName = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search your product...',
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('products')
                  .orderBy('productName')
                  .startAt([searchName]).endAt([searchName + "\uf8ff"]).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                    width: 45,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          productModel.categoryName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
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
                                                  decoration: TextDecoration
                                                      .lineThrough,
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
          ],
        ),
      ),
    );
  }
}
