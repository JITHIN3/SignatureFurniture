// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/admin_product_image_controller.dart';

class AdminAddPrdouctScreen extends StatelessWidget {
  AdminAddPrdouctScreen({super.key});

  AddProductImagesController addProductImagesController =
      Get.put(AddProductImagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Container(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Images"),
                ElevatedButton(
                    onPressed: () {
                      addProductImagesController.showImagesPickerDialog();
                    },
                    child: Text("Select Images"))
              ],
            ),
          ),
          GetBuilder<AddProductImagesController>(
              init: AddProductImagesController(),
              builder: (imageController) {
                return imageController.selectedImages.length > 0
                    ? Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: Get.height / 3.0,
                        child: GridView.builder(
                            itemCount: imageController.selectedImages.length,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemBuilder: (BuildContext context, index) {
                              return Stack(
                                children: [
                                  Image.file(
                                    File(
                                      addProductImagesController
                                          .selectedImages[index].path
                                          .toString(),
                                    ),
                                    fit: BoxFit.cover,
                                    height: Get.height / 4,
                                    width: Get.width / 2,
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                      onTap: () {
                                        imageController.removeImages(index);
                                        print(imageController.selectedImages.length);
                                      },
                                      child: CircleAvatar(radius: 15,
                                        backgroundColor: Colors.red,
                                        child: Icon(
                                          Icons.close,size: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      )
                    : SizedBox.shrink();
              })
        ]),
      ),
    );
  }
}
