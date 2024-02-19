import 'package:flutter/material.dart';
import 'package:signature_funiture_project/utils/app_constants.dart';

class MainSCreen extends StatelessWidget {
  const MainSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(AppConstant.appMainName),
      ),
    );
  }
}
