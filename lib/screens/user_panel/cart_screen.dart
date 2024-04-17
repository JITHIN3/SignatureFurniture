// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:signature_funiture_project/controllers/cart_price_controller.dart';
import 'package:signature_funiture_project/models/cart_model.dart';
import 'package:signature_funiture_project/models/order_model.dart';
import 'package:signature_funiture_project/screens/user_panel/checkout_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/product_details_screen.dart';

import '../../models/product_model.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  CartModel? cartModel;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: Image(
                    image: AssetImage("lib/assets/images/cartempty.png"),
                  ),
                ),
                Text(
                  "Cart is empty",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.grey.shade500),
                )
              ],
            ));
          }

          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final productData = snapshot.data!.docs[index];
                    CartModel cartModel = CartModel(
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
                        updatedAt: productData['updatedAt'],
                        productQuantity: productData['productQuantity'],
                        productTotalPrice: double.parse(
                            productData['productTotalPrice'].toString()));

                    // calculate price
                    productPriceController.fetchProductPrice();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child:
                                    Image.network(cartModel.productImages[0]),
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
                                      cartModel.productName,
                                      style: TextStyle(
                                          fontSize: 16,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                    ),
                                  ),
                                  Text(
                                    cartModel.categoryName,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                  ),
                                  Row(
                                    children: [
                                      cartModel.isSale == true &&
                                              cartModel.salePrice != ''
                                          ? Text(
                                              "₹" + cartModel.salePrice,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : Text(
                                              "₹" + cartModel.fullPrice,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      cartModel.isSale == true &&
                                              cartModel.fullPrice !=
                                                  cartModel.salePrice
                                          ? Text(
                                              "₹" + cartModel.fullPrice,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.grey),
                                            )
                                          : Container()
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Material(
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black,
                                      blurRadius: .5,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0)),
                              width: 100,
                              height: 32,
                              child: TextButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              if (cartModel.productQuantity >
                                                  1) {
                                                await FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(user!.uid)
                                                    .collection('cartOrders')
                                                    .doc(cartModel.productId)
                                                    .update({
                                                  'productQuantity': cartModel
                                                          .productQuantity -
                                                      1,
                                                  'productTotalPrice': (double
                                                          .parse(cartModel
                                                              .salePrice) *
                                                      (cartModel
                                                              .productQuantity -
                                                          1))
                                                });
                                              }
                                            },
                                            child: Text("-")),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(cartModel.productQuantity
                                              .toString()),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (cartModel.productQuantity > 0) {
                                              await FirebaseFirestore.instance
                                                  .collection('cart')
                                                  .doc(user!.uid)
                                                  .collection('cartOrders')
                                                  .doc(cartModel.productId)
                                                  .update({
                                                'productQuantity':
                                                    cartModel.productQuantity +
                                                        1,
                                                'productTotalPrice': double
                                                        .parse(cartModel
                                                            .salePrice) +
                                                    double.parse(cartModel
                                                            .salePrice) *
                                                        (cartModel
                                                            .productQuantity)
                                              });
                                            }
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Delivery by " + cartModel.deliveryTime,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "|",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "FREE Delivery",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    print('deleted');
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .delete();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.delete_outline_outlined,
                                          color: Colors.redAccent),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Divider(thickness: 5),
                        ),
                      ],
                    );
                  }),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Text(
                  "Total ₹${productPriceController.totalPrice.value.toStringAsFixed(1)} ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 8),
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10.0)),
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  child: TextButton(
                      onPressed: () {
                        productPriceController.totalPrice.value == 0
                            ? Get.snackbar("Add Product ", "Cart is empty",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.redAccent,
                                margin: EdgeInsets.all(20),
                                colorText: Colors.white)
                            : Get.to(
                                () => CheckOutScreen(),
                              );
                      },
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
