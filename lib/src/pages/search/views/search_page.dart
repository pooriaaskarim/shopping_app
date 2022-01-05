import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/search/controllers/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [TextFormField()],
        ),
        body: const SingleChildScrollView(
            // child:
            ));
  }
}
