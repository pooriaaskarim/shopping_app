import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/image_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/product_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/repositories/products_repository.dart';

class AdminProductsController extends GetxController {
  int userID = 0;
  Rxn<ProductsPageImageModel> userImage = Rxn<ProductsPageImageModel>();
  Rxn<AdminUserModel> user = Rxn<AdminUserModel>();
  RxList<AdminProductModel> productsList = <AdminProductModel>[].obs;
  RxList<ProductsPageImageModel> productImagesList =
      <ProductsPageImageModel>[].obs;
  final client = AdminProductsClient();

  Future getUser(int userID) async {
    Either<Exception, AdminUserModel> zResponse = await client.getUser(userID);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Connection Error'),
          action: SnackBarAction(
              label: 'Retry',
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

  Future<ProductsPageImageModel> getUserImage(int imageID) async {
    Either<Exception, ProductsPageImageModel> zResponse =
        await client.getUserImage(imageID);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle error
    }, (imageModel) {
      return imageModel;
    });
  }

//Fetch product and product images from server
  Future initProducts({bool refresh = false}) async {
    if (refresh) {
      productsList.clear();
      productImagesList.clear();
    }
    productImagesList.addAll(await getProductImages());
    productsList.addAll(await getProductsList());
  }

  Future<List<AdminProductModel>> getProductsList() async {
    Either<Exception, List<AdminProductModel>> zResponse =
        await client.getProductsList();
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Couldn\'t retrieve products.'),
          action: SnackBarAction(
              label: 'Retry',
              onPressed: () {
                getProductsList();
              })));
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future<List<ProductsPageImageModel>> getProductImages() async {
    Either<Exception, List<ProductsPageImageModel>> zResponse =
        await client.getProductImages();
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle error
    }, (list) {
      return list;
    });
  }

//Update product based on productLists items
  Future toggleProduct(int productID) async {
    AdminProductModel productModel = productsList.where((product) {
      return product.id == productID;
    }).toList()[0];
    Either<Exception, AdminProductModel> zResponse =
        await client.updateProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Connection Error'),
      ));
      throw Exception(exception);
    }, (model) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text.rich(TextSpan(children: [
          const TextSpan(text: 'Product '),
          TextSpan(
              text: '${model.name} ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: model.isEnabled ? 'enabled.' : 'disabled')
        ])),
        duration: const Duration(seconds: 2),
      ));
      // await Future.delayed(const Duration(seconds: 2));
      return Right(model);
    });
  }

  Future deleteProduct(AdminProductModel productModel) async {
    Either<Exception, dio.Response> zResponse =
        await client.deleteProduct(productModel);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Connection Error'),
      ));
      throw Exception(exception);
    }, (response) async {
      Either<Exception, dio.Response> zResponse =
          await client.deleteProductImage(productModel);
      zResponse.fold((exception) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text('Connection Error'),
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
