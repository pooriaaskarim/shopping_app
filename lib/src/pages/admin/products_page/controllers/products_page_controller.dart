import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/admin/products_page/repositories/products_repository.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';

class AdminProductsController extends GetxController {
  int userID = 0;
  Rxn<ImageModel> userImage = Rxn<ImageModel>();
  Rxn<UserModel> user = Rxn<UserModel>();
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxList<ImageModel> productImagesList = <ImageModel>[].obs;
  final client = AdminProductsClient();

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
      throw Exception(exception); //TODO: handle error
    }, (userModel) async {
      if (userModel.imageID != 0) {
        userImage.value = await getUserImage(userModel.imageID);
      }
      return userModel;
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
  Future initProducts({bool refresh = false}) async {
    if (refresh) {
      productsList.clear();
      productImagesList.clear();
    }
    productImagesList.addAll(await getProductImages());
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

//Update product based on productLists items
  Future toggleProduct(ProductModel productModel) async {
    Either<Exception, ProductModel> zResponse =
        await client.updateProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(LocaleKeys.error_data_connection_error.tr),
      ));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text.rich(TextSpan(children: [
          TextSpan(text: '${LocaleKeys.tr_data_product.tr} '),
          TextSpan(
              text: '${model.name} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text: model.isEnabled
                  ? LocaleKeys.tr_data_enabled.tr
                  : LocaleKeys.tr_data_disabled.tr)
        ])),
        duration: const Duration(seconds: 2),
      ));
      // await Future.delayed(const Duration(seconds: 2));
      return Right(model);
    });
  }

  Future deleteProduct(ProductModel productModel) async {
    Either<Exception, dio.Response> zResponse =
        await client.deleteProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(LocaleKeys.error_data_connection_error.tr),
      ));
      throw Exception(exception);
    }, (response) async {
      Either<Exception, dio.Response> zResponse =
          await client.deleteProductImage(productModel);
      zResponse.fold((exception) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_connection_error.tr),
        ));
        throw Exception(exception);
      }, (response) async {
        return Right(response);
      });
      return Right(response);
    });
  }

  @override
  void onInit() async {
    userID = int.parse(Get.parameters['id']!);
    if (userID != 0) {
      user.value = await getUser(userID); //TODO: handle client error
      // userImage.value = await getUserImage(user.value!.imageID);
    } //TODO: handle user retrieve error
    await initProducts();
    super.onInit();
  }

  @override
  void refresh() async {
    await initProducts(refresh: true);
    super.refresh();
  }
}
