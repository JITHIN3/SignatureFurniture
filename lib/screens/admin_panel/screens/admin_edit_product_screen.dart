// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/edit_product_controller.dart';

import '../controller/admin_category_dropdown_controller.dart';
import '../controller/is_sale_controller.dart';

class EditProductScreen extends StatelessWidget {
  ProductModel productModel;

  EditProductScreen({super.key, required this.productModel});

  IsSaleController isSaleController = Get.put(IsSaleController());
  CategoryDropDownController categoryDropDownController =
  Get.put(CategoryDropDownController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProductController>(
      init: EditProductController(productModel: productModel),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Edit Product : ${productModel.productName}",
              style: TextStyle(fontSize: 19),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 20,
                    height: Get.height / 4.0,
                    child: GridView.builder(
                        itemCount: controller.images.length,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2),
                        itemBuilder: (BuildContext context, index) {
                          return Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.images[index],
                                fit: BoxFit.contain,
                                height: Get.height / 5.5,
                                width: Get.width / 2,
                                placeholder: (context, url) =>
                                    Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: InkWell(
                                  onTap: () async {
                                    EasyLoading.show();
                                    await controller.deleteImagesFromStorage(
                                        controller.images[index].toString());
                                    await controller.deleteImageFireStore(
                                        controller.images[index].toString(),
                                        productModel.productId);
                                    EasyLoading.dismiss();
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.red,
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                  ),
                ),

                //Drope Down
                GetBuilder<CategoryDropDownController>(
                  init: CategoryDropDownController(),
                  builder: (categoriesDropDownController) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              value: categoriesDropDownController
                                  .selectedCategoryId?.value,
                              items: categoriesDropDownController.categories
                                  .map((category) {
                                return DropdownMenuItem<String>(
                                  value: category['categoryId'],
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          category['categoryImg'].toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(category['categoryName']),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? selectedValue) async {
                                categoriesDropDownController
                                    .setSelectedCategory(selectedValue);
                                String? categoryName =
                                await categoriesDropDownController
                                    .getCategoryName(selectedValue);
                                categoriesDropDownController
                                    .setSelectedCategoryName(categoryName);
                              },
                              hint: const Text(
                                'Select a category',
                              ),
                              isExpanded: true,
                              elevation: 10,
                              underline: const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // is sale

                GetBuilder<IsSaleController>(
                    init: IsSaleController(),
                    builder: (isSaleController) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Is Sale",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  Switch(
                                    value: isSaleController.isSale.value,
                                    activeColor: Colors.blueAccent,
                                    onChanged: (value) {
                                      isSaleController.toggleIsSale(value);
                                    },
                                  )
                                ]),
                          ),
                        ),
                      );
                    }),
                //form

                SizedBox(height: 10.0),
                Container(
                  height: 65,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    controller: productNameController
                      ..text = productModel.productName,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintText: "Product Name",
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Obx(() {
                  return isSaleController.isSale.value
                      ? Container(
                    height: 65,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextFormField(
                      cursorColor: Colors.blueAccent,
                      textInputAction: TextInputAction.next,
                      controller: salePriceController
                        ..text = productModel.salePrice,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        hintText: "Sale Price",
                        hintStyle: TextStyle(fontSize: 12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  )
                      : SizedBox.shrink();
                }),

            Container(
                  height: 65,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    controller: fullPriceController
                      ..text = productModel.fullPrice,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintText: "Full Price",
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: 65,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    controller: deliveryTimeController
                      ..text = productModel.deliveryTime,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintText: "Delivery Time",
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 20.0, vertical: 20.0),
                //   child: Container(
                //     child: TextFormField(
                //       minLines: 6,
                //       // any number you need (It works as the rows for the textarea)
                //       keyboardType: TextInputType.multiline,
                //       maxLines: null,
                //       controller: productDescriptionController,
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(),
                //         labelText: 'Address',
                //         contentPadding: EdgeInsets.symmetric(
                //           horizontal: 10.0,
                //         ),
                //         hintStyle: TextStyle(
                //           fontSize: 12,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    minLines: 6,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    cursorColor: Colors.blueAccent,
                    textInputAction: TextInputAction.next,
                    controller: productDescriptionController
                      ..text = productModel.productDescription,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintText: "Product Desc",
                      hintStyle: TextStyle(fontSize: 12.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SizedBox(
                      height: 50,
                      width: Get.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          EasyLoading.show();
                          ProductModel newProductModel = ProductModel(
                            productId: productModel.productId,
                            categoryId: categoryDropDownController
                                .selectedCategoryId
                                .toString(),
                            productName: productNameController.text.trim(),
                            categoryName: categoryDropDownController
                                .selectedCategoryName
                                .toString(),
                            salePrice: salePriceController.text != ''
                                ? salePriceController.text.trim()
                                : '',
                            fullPrice: fullPriceController.text.trim(),
                            productImages: productModel.productImages,
                            deliveryTime: deliveryTimeController.text.trim(),
                            isSale: isSaleController.isSale.value,
                            productDescription:
                            productDescriptionController.text.trim(),
                            createdAt: productModel.createdAt,
                            updatedAt: DateTime.now(),
                          );

                          await FirebaseFirestore.instance.collection(
                              'products').doc(productModel.productId).update(
                              newProductModel.toMap());

                          EasyLoading.dismiss();
                          Get.snackbar("Update Successfull", "Product update",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.green,
                              margin: EdgeInsets.all(20),
                              colorText: Colors.white);
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.green),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}
