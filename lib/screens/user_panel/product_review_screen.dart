import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/product_model.dart';

class ProductReviewScreen extends StatelessWidget {
  ProductReviewScreen(
      {super.key, required this.productModel, required this.productid});

  ProductModel productModel;
  String productid;

  final _reviewStream =
      FirebaseFirestore.instance.collection('reviews').get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reviews"),
        ),
        body: Column(children: [
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('reviews')
                  .where('productId', isEqualTo: productModel.productId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Connection Error");
                }
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      Center(
                        child: Text("No Review yet!"),
                      ),
                    ],
                  );
                }
                var docs = snapshot.data!.docs;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  top: 10, left: 10),
                              child:
                              SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Text(
                                              '${docs[index]['userName']} ',
                                              style: TextStyle(
                                                  fontSize:
                                                  15,color: Colors.grey)),

                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          "${docs[index]['review']}",
                                          style: TextStyle(
                                              fontSize:
                                              15)),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      
                                      Divider()

                                    ]),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }),
        ]),);
  }
}
