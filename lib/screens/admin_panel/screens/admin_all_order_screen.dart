import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_specific_customer_order_screen.dart';

import '../../../models/user_model.dart';
class AdminAllOrdersScreen extends StatelessWidget {
  const AdminAllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("All Orders"),),body:  FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text('Error occurred while fetching oders!'),
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
              child: Text('No oders found!'),
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


              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () => Get.to(
                    () => SpecificCustomerOrderScreen(
                        docId: snapshot.data!.docs[index]['uId'],
                        customerName: snapshot.data!.docs[index]
                            ['customerName']),
                  ),

                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                   child: Text(data['customerName'][0]),
                  ),
                  title: Text(data['customerName']),
                  subtitle: Text(data['customerPhone']),
                  trailing: Icon(Icons.edit),
                ),
              );
            },
          );
        }

        return Container();
      },
    ),);
  }
}
