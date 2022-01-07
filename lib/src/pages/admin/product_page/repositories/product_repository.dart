import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shopping_app/src/infrastructures/commons/repository_urls.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_image_dto.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_image_model.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_model.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_tag_dto.dart';
import 'package:shopping_app/src/pages/admin/product_page/models/product_tag_model.dart';
import 'package:shopping_app/src/pages/shared/repository/main_repository.dart';

class ProductClient extends Client {
  Future<Either<Exception, AdminProductModel>> getProduct(int productID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productById(productID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminProductModel.fromMap(response.data));
    });
  }

  Future<Either<Exception, AdminProductImageModel>> getProductImage(
      int imageID) async {
    Either<Exception, Response> zResponse =
        await dioGet(RepositoryUrls.productImageById(imageID));
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminProductImageModel.fromMap(response.data));
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

  Future<Either<Exception, AdminProductImageModel>> uploadImage(
      AdminProductImageDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productImages(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminProductImageModel.fromMap(response.data));
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

  Future<Either<Exception, AdminProductTagModel>> addTag(
      AdminProductTagDTO dto) async {
    Either<Exception, Response> zResponse =
        await dioPost(RepositoryUrls.productTags(), dto.toMap());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminProductTagModel.fromMap(response.data));
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

  Future<Either<Exception, List<AdminProductTagModel>>> getTagsList() async {
    // Retrieve Users List From Server
    List<AdminProductTagModel> tags = <AdminProductTagModel>[];
    var zResponse = await dioGet(RepositoryUrls.productTags());
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      for (var item in response.data) {
        tags.add(AdminProductTagModel.fromMap(item));
      }
      return Right(tags);
    });
  }
}
