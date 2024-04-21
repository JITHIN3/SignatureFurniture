import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:signature_funiture_project/controllers/cart_price_controller.dart';
import 'package:signature_funiture_project/models/cart_model.dart';
import 'package:signature_funiture_project/screens/user_panel/product_details_screen.dart';

import '../../controllers/get_customer_device_token_controller.dart';
import '../../models/product_model.dart';
import '../../services/place_order_service.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController landController = TextEditingController();
  TextEditingController cityController = TextEditingController();


  //payment

  TextEditingController? amountcon;
  Razorpay? _razorpay;




  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
    amountcon = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    print("success");
  }

  void handlePaymentError(PaymentSuccessResponse response) {
    print("fail");
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print("external wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .doc(user!.uid)
                  .collection('cartOrders')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Get.height / 5,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No product found!"),
                  );
                }

                if (snapshot.data != null) {
                  return Container(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final productData = snapshot.data!.docs[index];
                          CartModel cartModel = CartModel(
                            productId: productData['productId'],
                            categoryId: productData['categoryId'],
                            productName: productData['productName'],
                            categoryName: productData['categoryName'],
                            salePrice: productData['salePrice'],
                            fullPrice: productData['fullPrice'],
                            productImages: productData['productImages'],
                            deliveryTime: productData['deliveryTime'],
                            isSale: productData['isSale'],
                            productDescription:
                                productData['productDescription'],
                            createdAt: productData['createdAt'],
                            updatedAt: productData['updatedAt'],
                            productQuantity: productData['productQuantity'],
                            productTotalPrice: double.parse(
                                productData['productTotalPrice'].toString()),
                          );

                          // calculate price
                          productPriceController.fetchProductPrice();
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Image.network(
                                          cartModel.productImages[0]),
                                      width: 120,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: Get.width / 1.9,
                                          child: Text(
                                            cartModel.productName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 3,
                                          ),
                                        ),
                                        Text(
                                          cartModel.categoryName,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 11),
                                        ),
                                        Row(
                                          children: [
                                            cartModel.isSale == true &&
                                                    cartModel.salePrice != ''
                                                ? Text(
                                                    "₹" + cartModel.salePrice,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : Text(
                                                    "₹" + cartModel.fullPrice,
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            cartModel.isSale == true &&
                                                    cartModel.fullPrice !=
                                                        cartModel.salePrice
                                                ? Text(
                                                    "₹" + cartModel.fullPrice,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor:
                                                            Colors.grey),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.green,
                                        //       borderRadius:
                                        //           BorderRadius.circular(5)),
                                        //   height: 20,
                                        //   width: 40,
                                        //   child: Center(
                                        //     child: Row(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Text(
                                        //             "5",
                                        //             style: TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontWeight:
                                        //                     FontWeight.w600,
                                        //                 fontSize: 13),
                                        //           ),
                                        //           SizedBox(
                                        //             width: 2,
                                        //           ),
                                        //           Icon(
                                        //             Icons.star,
                                        //             color: Colors.white,
                                        //             size: 13,
                                        //           )
                                        //         ]),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Delivery by " +
                                              cartModel.deliveryTime,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "|",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "FREE Delivery",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          );

                          // return SwipeActionCell(
                          //   trailingActions: [
                          //     SwipeAction(
                          //       title: "Delete",
                          //       forceAlignmentToBoundary: true,
                          //       performsFirstActionWithFullSwipe: true,
                          //       onTap: (CompletionHandler handler) async {
                          //         print('deleted');
                          //         await FirebaseFirestore.instance
                          //             .collection('cart')
                          //             .doc(user!.uid)
                          //             .collection('cartOrders')
                          //             .doc(cartModel.productId)
                          //             .delete();
                          //       },
                          //     ),
                          //   ],
                          //   key: ObjectKey(cartModel.productId),
                          //   child: Card(
                          //     elevation: 5,
                          //     child: ListTile(
                          //       leading: CircleAvatar(
                          //         backgroundColor: Colors.lightBlueAccent,
                          //         backgroundImage:
                          //             NetworkImage(cartModel.productImages[0]),
                          //       ),
                          //       title: Text(cartModel.productName),
                          //       subtitle: Row(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Text(cartModel.productTotalPrice.toString()),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }),
                  );
                }

                return Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Price Details",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price"),
                        Text("₹" +
                            productPriceController.totalPrice.value
                                .toStringAsFixed(1))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Delivery Charges"),
                        Row(
                          children: [
                            Text(
                              "₹50",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  decorationColor: Colors.grey),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "FREE Delivery",
                              style: TextStyle(color: Colors.green),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹" +
                              productPriceController.totalPrice.value
                                  .toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Text(
                  "₹${productPriceController.totalPrice.value.toStringAsFixed(1)} ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 8, bottom: 8, top: 8),
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10.0)),
                  width: Get.width / 2.0,
                  height: Get.height / 18,
                  child: TextButton(
                      onPressed: () {
                        showCustomBottomSheet();
                      },
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "User Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Container(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Name',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Phone',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Container(
                  child: TextFormField(
                    minLines: 5,
                    // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Address',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Container(
                  height: 55.0,
                  child: TextFormField(
                    controller: pincodeController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Pin code',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 55.0,
                        child: TextFormField(
                          controller: landController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Landmark',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 55.0,
                        child: TextFormField(
                          controller: cityController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'City',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          backgroundColor: Colors.deepOrange,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        ),
                        onPressed: () async {
                          if (nameController.text != '' &&
                              phoneController.text != '' &&
                              addressController.text != '' &&
                              pincodeController.text != '' &&
                              landController.text != '' &&
                              cityController.text != '') {
                            String name = nameController.text.trim();
                            String phone = phoneController.text.trim();
                            String address = addressController.text.trim();
                            String pincode = pincodeController.text.trim();
                            String landmark = landController.text.trim();
                            String city = cityController.text.trim();
                            String customerToken = await getCustomerDeviceToken();

                            //place order serice

                            placeOrder(
                              context: context,
                              customerName: name,
                              customerPhone: phone,
                              customerAddress: address,
                              customerCity: city,
                              customerLandmark: landmark,
                              customerPincode: pincode,
                              customerDeviceToken: customerToken,
                            );
                          } else {
                            print("Please fill all details");
                            Get.snackbar("Warning!", "Please fill all details!",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                duration: Duration(seconds: 1),
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Text(
                          "Confirm Order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(width: 150,
                      child: ElevatedButton(
                          onPressed: () async{

                            if (nameController.text != '' &&
                                phoneController.text != '' &&
                                addressController.text != '' &&
                                pincodeController.text != '' &&
                                landController.text != '' &&
                                cityController.text != '') {
                              String name = nameController.text.trim();
                              String phone = phoneController.text.trim();
                              String address = addressController.text.trim();
                              String pincode = pincodeController.text.trim();
                              String landmark = landController.text.trim();
                              String city = cityController.text.trim();
                              String customerToken = await getCustomerDeviceToken();

                              if(phoneController.text.length < 10){

                                Get.snackbar(
                                    "Warning!", "Please fill all details!",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    duration: Duration(seconds: 1),
                                    snackPosition: SnackPosition.BOTTOM);

                              }

                              //place order serice

                              placeOrder(
                                context: context,
                                customerName: name,
                                customerPhone: phone,
                                customerAddress: address,
                                customerCity: city,
                                customerLandmark: landmark,
                                customerPincode: pincode,
                                customerDeviceToken: customerToken,
                              );


                              var options = {
                                'key': 'rzp_test_1DP5mmOlF5G5ag',
                                'amount':num.parse(productPriceController.totalPrice.value.toStringAsFixed(1)) * 100,
                                'name': 'Signature Funriture',

                                'retry': {'enabled': true},
                                'send_sms_hash': true,
                                'prefill': {
                                  'contact': '8943123283',
                                  'email': 'signaturefuniture@gamil.com'
                                },
                                'external': {
                                  'wallets': ['paytm']
                                }
                              };
                              try {
                                _razorpay!.open(options);
                              } catch (e) {
                                debugPrint("Error : $e");
                              }
                            } else {
                              print("Please fill all details");
                              Get.snackbar(
                                  "Warning!", "Please fill all details!",
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 1),
                                  snackPosition: SnackPosition.BOTTOM);
                            }

                          },
                          child: Text(
                            "Pay Now",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }
}
