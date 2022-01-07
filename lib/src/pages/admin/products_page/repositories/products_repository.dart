import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/image_model.dart';
import 'package:shopping_app/src/pages/admin/products_page/models/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

import '../models/product_model.dart';

class AdminProductsClient extends Client {
  Future<Either<Exception, AdminUserModel>> getUser(int userID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.userById(userID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminUserModel.fromJsonMap(response.data));
    });
  }

  Future<Either<Exception, ProductsPageImageModel>> getUserImage(
      int imageID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.userImageById(imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ProductsPageImageModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, List<ProductsPageImageModel>>>
      getProductImages() async {
    List<ProductsPageImageModel> imagesList = [];
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productImages());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var imageModel in response.data) {
        imagesList.add(ProductsPageImageModel.fromMap(imageModel));
      }
      return Right(imagesList);
    });
  }

  Future<Either<Exception, List<AdminProductModel>>> getProductsList() async {
    // Retrieve Users List From Server
    List<AdminProductModel> products = <AdminProductModel>[];
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.products());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        products.add(AdminProductModel.fromMap(item));
      }
      return Right(products);
    });
  }

  Future<Either<Exception, AdminProductModel>> updateProduct(
      AdminProductModel productModel) async {
    Either<Exception, Response> zResponse = await dioPut(
        RepositoryUrls.productById(productModel.id), productModel.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminProductModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, Response>> deleteProduct(
      AdminProductModel productModel) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productById(productModel.id));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) async {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> deleteProductImage(
      AdminProductModel productModel) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productImageById(productModel.imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) async {
      return Right(response);
    });
  }
}

// void main() async {
//   var client = SignUpClient();
//   await client.getUsersList('http://127.0.0.1:3000/users');
//   print(client.users);
// }
