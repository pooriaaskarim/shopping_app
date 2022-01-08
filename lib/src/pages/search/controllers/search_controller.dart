import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/search/repositories/search_repository.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';

class SearchController extends GetxController {
  final client = SearchClient();
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  Future<List<ProductModel>> getProductsList() async {
    Either<Exception, List<ProductModel>> zResponse =
        await client.getProductsList();
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_couldnt_retrieve_products.tr),
          action: SnackBarAction(
              label: LocaleKeys.error_data_retry.tr,
              onPressed: () {
                getProductsList();
              })));
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }
}
