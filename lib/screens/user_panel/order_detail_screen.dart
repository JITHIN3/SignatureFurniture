// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  String docId;
  OrderModel orderModel;

  OrderDetailScreen({super.key, required this.docId, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Details',
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
              Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Get.width / 1.9,
                            alignment: Alignment.topLeft,
                            child: Text(
                              orderModel.productName,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Image(
                                image: NetworkImage(
                              orderModel.productImages[0],
                            )),
                          )
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Text(
                                "₹" + orderModel.productTotalPrice.toString(),
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
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
                          Text("Quantity : " +
                              "x" +
                              orderModel.productQuantity.toString()),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimelineTile(
                      isFirst: true,
                      beforeLineStyle: LineStyle(
                        color: Colors.green,
                      ),
                      indicatorStyle: IndicatorStyle(
                          width: 40,
                          color: Colors.green,
                          iconStyle: IconStyle(
                              iconData: Icons.done, color: Colors.white),),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 5,
                      color: Colors.grey.shade300,
                    ),
                    Text(
                      "Shipping Details",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderModel.customerName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      orderModel.customerAddress,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      orderModel.customerPhone,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),

                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      orderModel.customerLandmark,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      orderModel.customerCity,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text("Pin : "+
                        orderModel.customerPincode,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 5,
                      color: Colors.grey.shade300,
                    ),
                    Text(
                      "Price Details",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("List Price"),
                          orderModel.isSale == true &&
                                  orderModel.salePrice != ''
                              ? Text(
                                  "₹" + orderModel.fullPrice,
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              : Text(
                                  "₹" + orderModel.fullPrice,
                                  style: TextStyle(),
                                )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Selling Price"),
                          orderModel.isSale == true &&
                                  orderModel.salePrice != ''
                              ? Text(
                                  "₹" + orderModel.salePrice,
                                )
                              : Text(
                                  "₹" + orderModel.fullPrice,
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Charges"),
                          Row(
                            children: [
                              Text(
                                "₹50",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    decorationColor: Colors.grey),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "FREE Delivery",
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "₹" + orderModel.productTotalPrice.toString(),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
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
