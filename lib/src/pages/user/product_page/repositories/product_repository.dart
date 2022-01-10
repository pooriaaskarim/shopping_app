import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class ProductClient extends Client {
  Future<Either<Exception, UserModel>> getUser(int userID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.userById(userID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(UserModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, ProductModel>> getProduct(int productID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productById(productID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ProductModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, ImageModel>> getProductImage(int imageID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productImageById(imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ImageModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, UserModel>> updateUser(UserModel userModel) async {
    Either<Exception, Response> zResponse =
        await dioPut(RepositoryUrls.userById(userModel.id), userModel.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(UserModel.fromMap(response.data));
    });
  }
}
