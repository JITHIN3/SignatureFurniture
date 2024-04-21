// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/models/cart_model.dart';
import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/screens/user_panel/cart_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/product_review_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/user_review_screen.dart';
import 'package:signature_funiture_project/widgets/similar_category_product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/all_product_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  String productid;

  ProductDetailsScreen(
      {super.key, required this.productModel, required this.productid});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController reviewcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: widget.productModel.productImages
                      .map(
                        (imageUrls) => ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            imageUrl: imageUrls,
                            fit: BoxFit.cover,
                            width: Get.width,
                            height: Get.height,
                            placeholder: (context, url) => ColoredBox(
                              color: Colors.white,
                              child:
                                  Center(child: CupertinoActivityIndicator()),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  )),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.productModel.productName,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.fade),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          widget.productModel.isSale == true &&
                                  widget.productModel.salePrice != ''
                              ? Text(
                                  "₹" + widget.productModel.salePrice,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "₹" + widget.productModel.fullPrice,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                          SizedBox(
                            width: 7,
                          ),
                          widget.productModel.isSale == true &&
                                  widget.productModel.fullPrice !=
                                      widget.productModel.salePrice
                              ? Text(
                                  "₹" + widget.productModel.fullPrice,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                              "Category : " + widget.productModel.categoryName),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Icon(
                              Icons.delivery_dining,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "FREE Delivery",
                              style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.w600),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text(
                              'Delivery by ' + widget.productModel.deliveryTime,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 3,
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.store,
                                  color: Colors.blueAccent,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  '7 Days Service Center\nReplacement/Repair',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Image(
                                    image: AssetImage(
                                        "lib/assets/images/money-stack.png"),
                                    height: 50,
                                  ),
                                ),
                                Text("Cash On Delivery available",
                                    style: TextStyle(fontSize: 12))
                              ],
                            ),
                          ]),
                    ),
                    Divider(
                      thickness: 3,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10,right: 5,bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(  onTap: () => Get.to(() => ProductReviewScreen(productModel: widget.productModel,
                      productid: widget.productModel.productId,)),
                      child: Text(
                        "View Reviews",
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => UserReviewScreen(
                            productid: widget.productModel.productId,
                            productModel: widget.productModel,
                          )),
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            "Add review",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.lightBlueAccent),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.productModel.productDescription),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Similar Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SingleCategory(categoryId: widget.productModel.categoryId),
              //
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.grey.shade200,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [],
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: Get.width / 3.0,
                    height: Get.height / 16,
                    child: TextButton(
                      onPressed: () {
                        sendMessageOnWhatsApp(
                            productModel: widget.productModel);
                      },
                      child: Text(
                        "Whatsapp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Material(
                color: Colors.grey.shade200,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [],
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: Get.width / 3.0,
                    height: Get.height / 16,
                    child: TextButton(
                      onPressed: () async {
                        await checkProductExistence(uId: user!.uid);
                      },
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> sendMessageOnWhatsApp({
    required ProductModel productModel,
  }) async {
    final number = "+918943123280";

    final message =
        "Hello Signature Furniture \nI want to know about this product\n ${productModel.productImages[0]}\nProduct name :${productModel.productName} \nProductId :${productModel.productId}";
    final url = 'https://wa.me/$number?text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //check
  Future<void> checkProductExistence({
    required String uId,
    int quantityIncrement = 1,
  }) async {
    EasyLoading.show(status: "Please wait..");
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(
          widget.productModel.productId.toString(),
        );
    DocumentSnapshot snapshot = await documentReference.get();

    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice) *
          updatedQuantity;
      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });

      Get.snackbar("Product alredy exsist", "Please check your cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pinkAccent,
          margin: EdgeInsets.all(20),
          colorText: Colors.white);
      EasyLoading.dismiss();
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });
      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.isSale
              ? widget.productModel.salePrice
              : widget.productModel.fullPrice));
      await documentReference.set(cartModel.toMap());

      print("product added");
      Get.snackbar("Product Added", "Please check your cart",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blueAccent,
          margin: EdgeInsets.all(20),
          colorText: Colors.white);
      EasyLoading.dismiss();
    }
  }
  // void showBottamsheet(){
  //   Get.bottomSheet();
  // }
}
