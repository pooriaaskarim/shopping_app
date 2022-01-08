import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class SearchClient extends Client {
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
}

// void main() async {
//   var client = SignUpClient();
//   await client.getUsersList('http://127.0.0.1:3000/users');
//   print(client.users);
// }
