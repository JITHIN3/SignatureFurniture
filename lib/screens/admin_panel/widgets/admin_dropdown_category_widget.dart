// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/admin_category_dropdown_controller.dart';

class DropDownCategoriesWiidget extends StatelessWidget {
  const DropDownCategoriesWiidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
      init: CategoryDropDownController(),
      builder: (categoriesDropDownController) {
        return Column(
          children: [
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300)),
              margin: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value:
                  categoriesDropDownController.selectedCategoryId?.value,
                  items:
                  categoriesDropDownController.categories.map((category) {
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
                    String? categoryName = await categoriesDropDownController
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
    );
  }
}