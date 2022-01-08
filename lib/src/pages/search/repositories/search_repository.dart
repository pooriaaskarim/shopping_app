import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/user/user_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class SearchClient extends Client {
  Future<Either<Exception, UserModel>> getUser(int userID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.userById(userID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(UserModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, ImageModel>> getUserImage(int imageID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.userImageById(imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ImageModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, List<ImageModel>>> getProductImages() async {
    List<ImageModel> imagesList = [];
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productImages());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var imageModel in response.data) {
        imagesList.add(ImageModel.fromMap(imageModel));
      }
      return Right(imagesList);
    });
  }

  Future<Either<Exception, List<ProductModel>>> getProductsList() async {
    // Retrieve Users List From Server
    List<ProductModel> products = <ProductModel>[];
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.products());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        products.add(ProductModel.fromMap(item));
      }
      return Right(products);
    });
  }

  Future<Either<Exception, ProductModel>> updateProduct(
      ProductModel productModel) async {
    Either<Exception, Response> zResponse = await dioPut(
        RepositoryUrls.productById(productModel.id), productModel.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ProductModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, Response>> deleteProduct(
      ProductModel productModel) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productById(productModel.id));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) async {
      return Right(response);
    });
  }

  Future<Either<Exception, Response>> deleteProductImage(
      ProductModel productModel) async {
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
