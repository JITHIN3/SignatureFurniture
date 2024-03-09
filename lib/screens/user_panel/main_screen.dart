import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature_funiture_project/screens/auth_ui/welcome_screen.dart';
import 'package:signature_funiture_project/screens/user_panel/all_category_screen.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';
import 'package:signature_funiture_project/widgets/banner_widget.dart';
import 'package:signature_funiture_project/widgets/category_widget.dart';
import 'package:signature_funiture_project/widgets/custom_drawer_widget.dart';
import 'package:signature_funiture_project/widgets/flash_sale_widget.dart';
import 'package:signature_funiture_project/widgets/heading_widget.dart';

class MainSCreen extends StatelessWidget {
  const MainSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            SizedBox(
              height: Get.height / 90.0,
            ),
            BannerWidget(),
            //heading
            HeadingWidget(
              headingTitle: "Categories",
              headingSubTitle: "According to your budget",
              onTap: ()=>Get.to(()=>AllCategoriesScreen()),
              buttonText: "See more > ",
            ),

            CategoriesWidget(),
            

            HeadingWidget(
              headingTitle: "Flash Sale",
              headingSubTitle: "According to your budget",
              onTap: () {},
              buttonText: "See more > ",
            ),
            FlashSaleWidget()
          ]),
        ),
      ),
      drawer: DrawerWidget(),
      drawerDragStartBehavior: DragStartBehavior.start,
    );
  }
}
