import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_image_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_model.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/repositories/add_product_repository.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';

class AddProductController extends GetxController {
  final client = AddProductClient();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  ImageHandler productImagerHandler = ImageHandler();
  bool isEnabled = true;
  RxList<AdminAddProductTagModel> tags = <AdminAddProductTagModel>[].obs;
  RxSet<String> productTags = <String>{}.obs;

  Future addTag(String tag) async {
    if (tags.map((e) => e.tag).toList().contains(tag)) {
      return;
    }
    Either<Exception, dio.Response> zResponse =
        await client.addTag(AdminAddProductTagDTO(tag: tag));
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (response) {
      return Right(AdminAddProductTagModel.fromMap(response.data[0]));
    });
  }

  Future deleteTag(int id) async {
    Either<Exception, dio.Response> zResponse = await client.deleteTag(id);
    return zResponse.fold((exception) {
      return Left(Exception(exception));
    }, (response) {
      return Right(AdminAddProductTagModel.fromMap(response.data[0]));
    });
  }

  Future getTags() async {
    Either<Exception, List<AdminAddProductTagModel>> zResponse =
        await client.getTagsList();
    return zResponse.fold((exception) {
      throw Exception(exception);
    }, (list) {
      return list;
    });
  }

  Future uploadImage() async {
    Either<Exception, dio.Response>? zResponse;
    AdminAddProductImageDTO dto = AdminAddProductImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    zResponse = await client.uploadImage(dto);
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: handle Error
    }, (response) {
      return response.data['id'];
    });
  }

  Future addProduct() async {
    Either<Exception, dio.Response>? zResponse;
    int _imageID = 0;
    if (productImagerHandler.imageFile.value != null) {
      _imageID = await uploadImage();
    }

    var dto = AdminAddProductDTO(
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        tags: productTags.toList(),
        inStock: int.parse(inStockController.text),
        imageID: _imageID,
        isEnabled: isEnabled);
    zResponse = await client.addProduct(dto);
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(const SnackBar(content: Text('Connection Error')));
      throw Exception(exception);
    }, (response) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Product ${nameController.text} added.')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }

  String? inStockValidator(String? v) {
    if (v == null || v.isEmpty) {
      return 'Field can not be empty';
    } else if (int.parse(v) < 0) {
      return 'Invalid input';
    }
    return null;
  }

  String? tagsValidator(String? tagsSet) {
    if (productTags.isEmpty) {
      return 'At least one tag should be specified';
    }
    return null;
  }

  @override
  void onInit() async {
    tags.addAll(await getTags());
    super.onInit();
  }

  @override
  void refresh() async {
    tags.clear();
    tags.addAll(await getTags());
    super.refresh();
  }
}
