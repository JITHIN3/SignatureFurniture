import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
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
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
          SizedBox(
          child: TextFormField(
          controller: amountcon,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter value";
              }
              return null;
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              var options = {
                'key': 'rzp_test_1DP5mmOlF5G5ag',
                'amount': 200 *100,
                'name': 'Signature Funriture',
                'description': 'Fine T-Shirt',
                'retry': {'enabled': true, 'max_count': 1},
                'send_sms_hash': true,
                'prefill': {
                  'contact': '8943123283',
                  'email': 'test@razorpay.com'
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
            },

            child: Text("Pay"))],
    )
    )
    ,
    );
  }
}
