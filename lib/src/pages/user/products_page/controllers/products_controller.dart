import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/cart_item_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/user/products_page/repositories/products_repository.dart';

class UserProductsController extends GetxController {
  int userID = 0;
  Rxn<ImageModel> userImage = Rxn<ImageModel>();
  Rxn<UserModel> user = Rxn<UserModel>();
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxSet<CartItemModel> userShoppingCart = <CartItemModel>{}.obs;
  final client = UserProductsClient();

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
      if (userModel.imageID != 0) {
        userImage.value = await getUserImage(userModel.imageID);
      }
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

  Future<ImageModel> getUserImage(int imageID) async {
    Either<Exception, ImageModel> zResponse =
        await client.getUserImage(imageID);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle error
    }, (imageModel) {
      return imageModel;
    });
  }

//Fetch products and product images from server
  Future initPage({bool refresh = false}) async {
    if (refresh) {
      productsList.clear();
      user.value = await getUser(userID);
    }
    productsList.addAll(await getProductsList());
  }

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
    userID = int.parse(Get.parameters['id']!);
    user.value = await getUser(userID);
    await initPage();
    super.onInit();
  }

  @override
  void refresh() async {
    await initPage(refresh: true);
    super.refresh();
  }
}
