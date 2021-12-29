import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/products_page/controllers/products_page_controller.dart';

class AdminProductsPage extends StatelessWidget {
  AdminProductsPage({Key? key}) : super(key: key);
  final controller = Get.put(AdminPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            // child:
            ));
  }
}
