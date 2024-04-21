import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/category_controller.dart';
import 'package:signature_funiture_project/models/category_model.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_add_product_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_order_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_product_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_all_users_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/screens/admin_review_screen.dart';
import 'package:signature_funiture_project/screens/admin_panel/widgets/admin_drawer_widget.dart';
import 'package:signature_funiture_project/widgets/all_product_widget.dart';
import 'package:signature_funiture_project/widgets/custom_drawer_widget.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  final CategoryController categoryController = Get.put(CategoryController());

  TextEditingController cname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(1),
                Colors.white.withOpacity(1),
                Colors.blue.withOpacity(.8),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Welcome! \nAdmin",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => AdminAddPrdouctScreen());
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.transparent.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Add Product",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AdminAllOrdersScreen());
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(
                                Icons.delivery_dining,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Orders",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AdminAllUsersScreen());
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.transparent.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Users",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),

                //second row
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>AdminAllProductsScreen());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(
                                    Icons.shelves,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Products",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>AdminViewReview());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Icon(
                                    Icons.message_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Reviews",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.transparent.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10)),

                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "All Product",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
                  ),
                ),
                AllProductWidget()
              ],
            ),
          ),
        ),
      ),
      drawer: AdminDrawerWidget(),
    );
  }
}
