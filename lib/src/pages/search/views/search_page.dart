import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/search/controllers/search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            height: 40,
            child: TextFormField(
                decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: MaterialTheme.editingColor),
                borderRadius: BorderRadius.circular(50.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 1, color: MaterialTheme.editingColor),
                borderRadius: BorderRadius.circular(50.0),
              ),
              isDense: true,
              prefixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 13,
                  ),
                  onPressed: () {}),
              suffixIcon:
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            )),
          ),
          actions: [],
        ),
        body: const SingleChildScrollView(
            // child:
            ));
  }
}
