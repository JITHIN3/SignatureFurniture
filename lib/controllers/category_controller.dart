import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/models/category_model.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> categoryMethod(

    String categoryName,
  ) async {
    try {


      CategoriesModel categoriesModel = CategoriesModel(
          categoryId: "",
          categoryImg: "",
          categoryName: categoryName,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now());
      EasyLoading.show(status: "Please Wait..");
      await _firestore.collection('category').doc().set(categoriesModel.toMap());
      EasyLoading.dismiss();
      Get.snackbar(
          "Done", "Category addedd succcessfull ",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.green,
          colorText: Colors.white);
      EasyLoading.dismiss();
    } catch (e) {
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.blue,
          colorText: Colors.white);

    }
  }
}
