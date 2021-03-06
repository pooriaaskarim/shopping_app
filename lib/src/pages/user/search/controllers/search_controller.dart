import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/user/search/repositories/search_repository.dart';

class UserSearchController extends GetxController {
  int userID = 0;
  final client = UserSearchClient();
  final searchbarController = TextEditingController();
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
      return list.where((e) => e.isEnabled).toList();
    });
  }

  Future<ImageModel> getProductImage(ProductModel productModel) async {
    Either<Exception, ImageModel> zResponse =
        await client.getProductImage(productModel.imageID);
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
    }, (imageModel) {
      return imageModel;
    });
  }

  @override
  void onInit() async {
    userID = int.parse(Get.parameters['userID']!);
    productsList.value = await getProductsList();
    super.onInit();
  }
}
