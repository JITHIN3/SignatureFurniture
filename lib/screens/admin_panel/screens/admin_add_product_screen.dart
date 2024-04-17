// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:signature_funiture_project/models/product_model.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/admin_category_dropdown_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/admin_product_image_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/controller/is_sale_controller.dart';
import 'package:signature_funiture_project/screens/admin_panel/services/generate_ids_service.dart';
import 'package:signature_funiture_project/screens/admin_panel/widgets/admin_dropdown_category_widget.dart';

class AdminAddPrdouctScreen extends StatelessWidget {
  AdminAddPrdouctScreen({super.key});

  AddProductImagesController addProductImagesController =
  Get.put(AddProductImagesController());
  CategoryDropDownController categoryDropDownController =
  Get.put(CategoryDropDownController());
  IsSaleController isSaleController = Get.put(IsSaleController());

  TextEditingController productNameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController fullPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


            Center(child: Image(image: AssetImage('lib/assets/images/Add notes-bro.png'),height: 200,)),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Select Images",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addProductImagesController.showImagesPickerDialog();
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            primary: Colors.lightBlue),
                        child: Text(
                          "Select Image",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            GetBuilder<AddProductImagesController>(
                init: AddProductImagesController(),
                builder: (imageController) {
                  return imageController.selectedImages.length > 0
                      ? Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 20,
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
                                    print(imageController
                                        .selectedImages.length);
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
                  )
                      : SizedBox.shrink();
                }),
            //show categories dropdown
            DropDownCategoriesWiidget(),

            //is sale

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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Is Sale",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
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
                })

            //form widget

            ,
            SizedBox(height: 10.0),
            Container(
              height: 65,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                cursorColor: Colors.blueAccent,
                textInputAction: TextInputAction.next,
                controller: productNameController,
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
                  controller: salePriceController,
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
                controller: fullPriceController,
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
                controller: deliveryTimeController,
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
              padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: TextFormField(
                minLines: 6,
                // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.blueAccent,
                textInputAction: TextInputAction.next,
                controller: productDescriptionController,
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
                      // String productId = await GenerateIds().generateProductId();
                      // print(productId);

                      if (productNameController.text.isEmpty ||
                          fullPriceController.text.isEmpty ||
                          deliveryTimeController.text.isEmpty ||
                          productDescriptionController.text.isEmpty||categoryDropDownController.isNull){
                        Get.snackbar(
                            "Warning", "Please Enter all Details",
                            snackPosition: SnackPosition.BOTTOM,
                            margin: EdgeInsets.all(20),

                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white);
                      }else{

                      try {
                        EasyLoading.show(status: "Please Wait..");
                        await addProductImagesController.uploadFunction(
                            addProductImagesController.selectedImages);
                        print(addProductImagesController.arrImagesUrl);

                        String productId =
                        await GenerateIds().generateProductId();

                        ProductModel productModel = ProductModel(
                          productId: productId,
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
                          productImages:
                          addProductImagesController.arrImagesUrl,
                          deliveryTime: deliveryTimeController.text.trim(),
                          isSale: isSaleController.isSale.value,
                          productDescription:
                          productDescriptionController.text.trim(),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),

                        );


                          await FirebaseFirestore.instance
                              .collection('products')
                              .doc(productId)
                              .set(productModel.toMap());
                        EasyLoading.dismiss();
                        productNameController.clear();
                        deliveryTimeController.clear();
                        fullPriceController.clear();
                        productDescriptionController.clear();
                        Get.snackbar("Upload Successfull", "New Product Added",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            margin: EdgeInsets.all(20),
                            colorText: Colors.white);


                      } catch (e) {
                        Get.snackbar("Please try again", "Error : $e",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            margin: EdgeInsets.all(20),
                            colorText: Colors.white);
                        print("error : $e");
                      }
                    }
                      },
                    child: Text(
                      "Upload",
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
  }
}
