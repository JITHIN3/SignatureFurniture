import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:signature_funiture_project/controllers/category_controller.dart';
import 'package:signature_funiture_project/models/category_model.dart';

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
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(controller: cname,
                decoration: InputDecoration(hintText: "CategoryName"),
              ),
            ),
            Center(
              child: ElevatedButton(onPressed: () async{


                String name = cname.text.trim();

                if (name.isEmpty  ){
                  Get.snackbar(
                      "Error", "Please Enter all Details",
                      snackPosition: SnackPosition.BOTTOM,
                      margin: EdgeInsets.all(20),

                      backgroundColor: Colors.pink,
                      colorText: Colors.white);
                }else{
                  await categoryController.categoryMethod(name);
                  cname.clear();



                }




              }, child: Text("Submit")),
            ),
          ],
        ));
  }
}
