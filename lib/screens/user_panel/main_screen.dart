import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature_funiture_project/models/cart_model.dart';
import 'package:signature_funiture_project/models/user_model.dart';
import 'package:signature_funiture_project/screens/auth_ui/welcome_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/all_category_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/all_flas_sale_product.dart';
import 'package:signature_funiture_project/screens/user_panel/all_product_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/cart_screen.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';
import 'package:signature_funiture_project/widgets/all_product_widget.dart';
import 'package:signature_funiture_project/widgets/banner_widget.dart';
import 'package:signature_funiture_project/widgets/category_widget.dart';
import 'package:signature_funiture_project/widgets/custom_drawer_widget.dart';
import 'package:signature_funiture_project/widgets/flash_sale_widget.dart';
import 'package:signature_funiture_project/widgets/heading_widget.dart';

import '../../models/product_model.dart';

class MainSCreen extends StatefulWidget {
  MainSCreen({super.key, this.productModel,this.cartModel});

  ProductModel? productModel;
  CartModel? cartModel;


  @override
  State<MainSCreen> createState() => _MainSCreenState();
}

class _MainSCreenState extends State<MainSCreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "It All Starts Here!",
          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: Get.height / 90.0,
            ),
            BannerWidget(),
            //heading
            HeadingWidget(
              headingTitle: "Categories",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => AllCategoriesScreen()),
              buttonText: "See more >",
            ),

            CategoriesWidget(),

            HeadingWidget(
              headingTitle: "Flash Sale",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => AllFlashSaleProductScreen()),
              buttonText: "See more >",
            ),
            FlashSaleWidget(),

            HeadingWidget(
              headingTitle: "All Products",
              headingSubTitle: "According to your budget",
              onTap: () => Get.to(() => AllProductScreen()),
              buttonText: "See more >",
            ),

            AllProductWidget()
          ]),
        ),
      ),
      drawer: DrawerWidget(),
      drawerDragStartBehavior: DragStartBehavior.start,
    );
  }
}
