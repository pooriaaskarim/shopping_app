import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/shopping_app.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/user/product_page/repositories/product_repository.dart';

class UserProductController extends GetxController {
  final client = ProductClient();
  int productID = 0, userID = 0;
  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<ProductModel> product = Rxn<ProductModel>();
  Rxn<ImageModel> productImage = Rxn<ImageModel>();

  Future<ProductModel> getProduct(int productID) async {
    Either<Exception, ProductModel> zResponse =
        await client.getProduct(productID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t retrieve product.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                getProduct(productID);
              })));
      const Text('Unable to load page');
      throw Exception(exception);
    }, (productModel) {
      return productModel;
    });
  }

  Future<ImageModel> getProductImage(int imageID) async {
    Either<Exception, ImageModel> zResponse =
        await client.getProductImage(imageID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t retrieve product.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                getProductImage(imageID);
              })));
      const Text('Unable to load page');
      throw Exception(exception);
    }, (productImageModel) {
      return productImageModel;
    });
  }

  Future getUser(int userID) async {
    Either<Exception, UserModel> zResponse = await client.getUser(userID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_connection_error.tr),
          action: SnackBarAction(
              label: LocaleKeys.error_data_retry.tr,
              onPressed: () {
                getUser(userID);
              })));
      throw Exception(exception);
    }, (userModel) async {
      return userModel;
    });
  }

  Future<UserModel> updateUserFavorites() async {
    Either<Exception, UserModel> zResponse =
        await client.updateUser(user.value!);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception);
    }, (model) async {
      return model;
    });
  }

  Future updateShoppingCart(UserModel userModel) async {
    Either<Exception, UserModel> zResponse = await client.updateUser(userModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(LocaleKeys.error_data_connection_error.tr),
      ));
      throw Exception(exception);
    }, (model) async {
      return model;
    });
  }

  @override
  void onInit() async {
    productID = int.parse(Get.parameters['productID']!);
    userID = int.parse(Get.parameters['userID']!);
    user.value = await getUser(userID);
    product.value = await getProduct(productID);
    super.onInit();
  }
}
