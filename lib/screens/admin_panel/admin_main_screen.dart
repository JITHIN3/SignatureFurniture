import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/category_controller.dart';
import 'package:signature_funiture_project/models/category_model.dart';
import 'package:signature_funiture_project/screens/admin_panel/widgets/admin_drawer_widget.dart';
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
        appBar: AppBar(
          title: Text("Admin Panel"),
        ),


    drawer:AdminDrawerWidget(),);
  }
}
