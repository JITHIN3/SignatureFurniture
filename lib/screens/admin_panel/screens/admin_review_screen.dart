import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewReview extends StatefulWidget {
  const AdminViewReview({super.key});

  @override
  State<AdminViewReview> createState() => _AdminViewReviewState();
}

class _AdminViewReviewState extends State<AdminViewReview> {
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
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Connection Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
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
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${docs[index]['userName']} ',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Product Name : ${docs[index]['productName']}",
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("ProductId : ${docs[index]['productId']}",
                                        style: TextStyle(fontSize: 15)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Category : ${docs[index]['categoryName']}",
                                        style: TextStyle(fontSize: 15)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("User Review : ${docs[index]['review']}",
                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.green),),
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
      ]),
    );
  }
}
