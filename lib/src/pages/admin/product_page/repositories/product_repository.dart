import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';
import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';
import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_dto.dart';
import 'package:shopping_app/src/pages/shared/models/tag/tag_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class AdminProductClient extends Client {
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

  Future<Either<Exception, ImageModel>> uploadImage(ImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productImages(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(ImageModel.fromMap(response.data));
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

  Future<Either<Exception, TagModel>> addTag(TagDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productTags(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(TagModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, Response>> deleteTag(int id) async {
    Either<Exception, Response> zResponse =
        await dioDelete(RepositoryUrls.productById(id));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(response);
    });
  }

  Future<Either<Exception, List<TagModel>>> getTagsList() async {
    // Retrieve Users List From Server
    List<TagModel> tags = <TagModel>[];
    var zResponse = await dioGet(RepositoryUrls.productTags());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        tags.add(TagModel.fromMap(item));
      }
      return Right(tags);
    });
  }
}
