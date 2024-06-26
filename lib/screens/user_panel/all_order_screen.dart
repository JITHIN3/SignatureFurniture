// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swipe_action_cell/core/cell.dart';
// import 'package:get/get.dart';
// import 'package:image_card/image_card.dart';
// import 'package:signature_funiture_project/controllers/cart_price_controller.dart';
// import 'package:signature_funiture_project/models/cart_model.dart';
// import 'package:signature_funiture_project/models/order_model.dart';
// import 'package:signature_funiture_project/screens/user_panel/checkout_screen.dart';
// import 'package:signature_funiture_project/screens/user_panel/product_details_screen.dart';
//
// import '../../models/product_model.dart';
//
// class AllOrderScreen extends StatefulWidget {
//   const AllOrderScreen({super.key});
//
//   @override
//   State<AllOrderScreen> createState() => _AllOrderScreenState();
// }
//
// class _AllOrderScreenState extends State<AllOrderScreen> {
//   User? user = FirebaseAuth.instance.currentUser;
//   final ProductPriceController productPriceController =
//       Get.put(ProductPriceController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text("My Orders"),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('orders')
//             .doc(user!.uid)
//             .collection('confirmOrders')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text("Error"),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Container(
//               height: Get.height / 5,
//               child: Center(
//                 child: CupertinoActivityIndicator(),
//               ),
//             );
//           }
//
//           if (snapshot.data!.docs.isEmpty) {
//             return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 200,
//                       child: Image(
//                         image: AssetImage("lib/assets/images/orderempty.png"),
//                       ),
//                     ),
//                     Text(
//                       "Order is empty",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 15,
//                           color: Colors.grey.shade500),
//                     )
//                   ],
//                 ));
//           }
//
//           if (snapshot.data != null) {
//             return Container(
//               child: ListView.builder(
//                   itemCount: snapshot.data!.docs.length,
//                   shrinkWrap: true,
//                   physics: BouncingScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final productData = snapshot.data!.docs[index];
//                     OrderModel orderModel = OrderModel(
//                         productId: productData['productId'],
//                         categoryId: productData['categoryId'],
//                         productName: productData['productName'],
//                         categoryName: productData['categoryName'],
//                         salePrice: productData['salePrice'],
//                         fullPrice: productData['fullPrice'],
//                         productImages: productData['productImages'],
//                         deliveryTime: productData['deliveryTime'],
//                         isSale: productData['isSale'],
//                         productDescription: productData['productDescription'],
//                         createdAt: productData['createdAt'],
//                         updatedAt: productData['updatedAt'],
//                         productQuantity: productData['productQuantity'],
//                         productTotalPrice: double.parse(
//                             productData['productTotalPrice'].toString()),
//                         customerId: productData['productTotalPrice'],
//                         status: productData['status'],
//                         customerName: productData['customerName'],
//                         customerAddress: productData['customerAddress'],
//                         customerDeviceToken: productData['customerDeviceToken'],
//                         customerPhone: productData['customerPhone']);
//
//                     // calculate price
//                     productPriceController.fetchProductPrice();
//
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Container(
//                                 child:
//                                     Image.network(orderModel.productImages[0]),
//                                 width: 120,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     orderModel.productName,
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   Text(
//                                     orderModel.categoryName,
//                                     style: TextStyle(
//                                         color: Colors.grey, fontSize: 11),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         "₹" + orderModel.fullPrice,
//                                         style: TextStyle(
//                                             decoration:
//                                                 TextDecoration.lineThrough,
//                                             fontSize: 15,
//                                             color: Colors.grey),
//                                       ),
//                                       SizedBox(
//                                         width: 6,
//                                       ),
//                                       Text(
//                                         "₹" + orderModel.salePrice,
//                                         style: TextStyle(
//                                             fontSize: 17,
//                                             fontWeight: FontWeight.w500),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10, top: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Delivery by " + orderModel.deliveryTime,
//                                     style: TextStyle(fontSize: 13),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     "|",
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     "FREE Delivery",
//                                     style: TextStyle(
//                                         color: Colors.green,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10, bottom: 10),
//                           child: Divider(thickness: 5),
//                         ),
//                       ],
//                     );
//                   }),
//             );
//           }
//
//           return Container();
//         },
//       ),
//     );
//   }
// }


// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_price_controller.dart';
import '../../models/order_model.dart';
import 'order_detail_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
  Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Your Orders'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .doc(user!.uid)
            .collection('confirmOrders')
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
                        image: AssetImage("lib/assets/images/orderempty.png"),
                      ),
                    ),
                    Text(
                      "Order is empty",
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
                  OrderModel orderModel = OrderModel(
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
                        productData['productTotalPrice'].toString()),
                    customerId: productData['customerId'],
                    status: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                    customerCity:productData['customerCity'],
                    customerLandmark: productData['customerLandmark'],
                    customerPincode: productData['customerPincode'],

                  );

                  //calculate price
                  productPriceController.fetchProductPrice();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Image.network(
                                    orderModel.productImages[0]),
                                width: 80,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(width:Get.width / 1.9,
                                    child: Text(
                                      orderModel.productName,
                                      style: TextStyle(
                                          fontSize: 16,

                                          overflow: TextOverflow.ellipsis,

                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                    ),
                                  ),
                                  Text(
                                    orderModel.categoryName,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                  ),
                                  Row(children: [

                                    Text("Status : ",style: TextStyle(color: Colors.grey),),

                                    orderModel.status != true
                                        ? Text(
                                      "Pending..",
                                      style: TextStyle(color: Colors.green),
                                    )
                                        : Text(
                                      "Deliverd",
                                      style: TextStyle(color: Colors.red),
                                    )

                                  ],)



                                ],
                              ),
                            )
                          ],
                        ),
                      onTap: (){
                        Get.to(
                              () => OrderDetailScreen(
                                docId: snapshot.data!.docs[index].id,
                                orderModel: orderModel,),
                        );

                      },),

                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          thickness: 3,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ],
                  );
                    Card(
                    elevation: 5,
                    color: Colors.grey,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        backgroundImage:
                        NetworkImage(orderModel.productImages[0]),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productTotalPrice.toString()),
                          SizedBox(
                            width: 10.0,
                          ),
                          orderModel.status != true
                              ? Text(
                            "Pending..",
                            style: TextStyle(color: Colors.green),
                          )
                              : Text(
                            "Deliverd",
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
