import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/admin/search/repositories/search_repository.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';

class AdminSearchController extends GetxController {
  final client = SearchClient();
  final searchbarController = TextEditingController();
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxList<ImageModel> productImagesList = <ImageModel>[].obs;
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

  Future<List<ImageModel>> getProductImages() async {
    Either<Exception, List<ImageModel>> zResponse =
        await client.getProductImages();
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content:
              Text(LocaleKeys.error_data_couldnt_retrieve_product_images.tr),
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

  Future initProducts({bool refresh = false}) async {
    if (refresh) {
      productsList.clear();
      productImagesList.clear();
    }
    productImagesList.addAll(await getProductImages());
    productsList.addAll(await getProductsList());
  }

  @override
  void onInit() async {
    await initProducts();
    super.onInit();
  }
}
