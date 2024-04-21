// ignore_for_file: prefer_const_constructors, file_names, must_be_immutable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/models/product_model.dart';

class AdminSingleProductDetailScreen extends StatelessWidget {
  ProductModel productModel;

  AdminSingleProductDetailScreen({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(fontSize: 18),
        ),
       
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: productModel.productImages
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
                            productModel.productName,
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
                          Text("Category : " + productModel.categoryName),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          productModel.isSale == true &&
                                  productModel.salePrice != ''
                              ? Row(
                                  children: [
                                    Text("Sale Price : "),
                                    Text(
                                      "₹" + productModel.salePrice,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    productModel.isSale == true &&
                            productModel.fullPrice != productModel.salePrice
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Full Price : "),
                                Text(
                                  "₹" + productModel.fullPrice,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      decorationColor: Colors.grey),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("ProductId : "),
                              Text(
                                productModel.productId,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    decorationColor: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text("CategoryId : "),
                              Text(
                                productModel.categoryId,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    decorationColor: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                "Is Sale : ",
                              ),
                              Text(
                                productModel.isSale.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    decorationColor: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                      color: Colors.grey.shade300,
                    ),
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
                    Text(productModel.productDescription),
                  ],
                ),
              ),

              //
            ],
          ),
        ),
      ),
    );
  }
}
