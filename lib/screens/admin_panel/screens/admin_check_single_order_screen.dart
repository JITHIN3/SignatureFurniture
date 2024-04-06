// ignore_for_file: must_be_immutable, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../models/order_model.dart';

class CheckSingleOrderScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;

  CheckSingleOrderScreen({
    super.key,
    required this.docId,
    required this.orderModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order'),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.productName),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.productTotalPrice.toString()),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text('x' + orderModel.productQuantity.toString()),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.productDescription),
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         CircleAvatar(
      //           radius: 50.0,
      //           foregroundImage: NetworkImage(orderModel.productImages[0]),
      //         ),
      //         CircleAvatar(
      //           radius: 50.0,
      //           foregroundImage: NetworkImage(orderModel.productImages[1]),
      //         )
      //       ],
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.customerName),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.customerPhone),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.customerAddress),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(orderModel.customerId),
      //     ),
      //   ],
      // ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CarouselSlider(
              //     items: orderModel.productImages
              //         .map(
              //           (imageUrls) => ClipRRect(
              //         borderRadius: BorderRadius.circular(0),
              //         child: CachedNetworkImage(
              //           imageUrl: imageUrls,
              //           fit: BoxFit.cover,
              //           width: Get.width,
              //           height: Get.height,
              //           placeholder: (context, url) => ColoredBox(
              //             color: Colors.white,
              //             child:
              //             Center(child: CupertinoActivityIndicator()),
              //           ),
              //           errorWidget: (context, url, error) =>
              //               Icon(Icons.error),
              //         ),
              //       ),
              //     )
              //         .toList(),
              //     options: CarouselOptions(
              //       height: 300,
              //       aspectRatio: 16 / 9,
              //       viewportFraction: 0.8,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: Duration(seconds: 3),
              //       autoPlayAnimationDuration: Duration(milliseconds: 800),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //       scrollDirection: Axis.horizontal,
              //     )),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "Product Name : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                orderModel.productName,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "Total Price : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "₹"+orderModel.productTotalPrice.toString(),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ), SizedBox(width: 5,),

                              orderModel.isSale == true &&
                                  orderModel.salePrice != ''
                                  ? Text("("
                                "₹" + orderModel.salePrice.toString()+")",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                                  : Text("("
                                "₹" + orderModel.fullPrice.toString()+")",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ),


                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Category : " + orderModel.categoryName),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Quantity : " + "x"+orderModel.productQuantity.toString()),
                        ],
                      ),
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
                              "Delivery Time",
                              style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.w600),
                            ),
                            VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text(
                              orderModel.deliveryTime,
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
                  ],
                ),
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
                    Text(orderModel.productDescription),
                  ],
                ),
              ),
              SizedBox(height: 8,),

              CarouselSlider(
                  items: orderModel.productImages
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
                    height: 200,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Details",
                      style:
                      TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("User Name : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                        Text(orderModel.customerName,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    SizedBox(height:5,),
                    Row(
                      children: [
                        Text("Phone : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                        Text(orderModel.customerPhone,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    SizedBox(height:5,),
                    Row(
                      children: [
                        Text("Address : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                        Text(orderModel.customerAddress,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                      ],
                    ),
                    SizedBox(height:5,),

                  ],
                ),
              ),





            ],
          ),
        ),
      ),
    );
  }
}
