import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/generated/locales.g.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_image_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_image_model.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_model.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_dto.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/models/add_product_tag_model.dart';
import 'package:shopping_app/src/pages/admin/add_product_page/repositories/add_product_repository.dart';
import 'package:shopping_app/src/pages/shared/image_handler.dart';

class AdminAddProductController extends GetxController {
  final client = AddProductClient();
  TextEditingController nameController = TextEditingController();
  TextEditingController inStockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  ImageHandler productImagerHandler = ImageHandler();
  RxBool isEnabled = true.obs;
  RxList<AdminAddProductTagModel> tags = <AdminAddProductTagModel>[].obs;
  RxSet<String> productTags = <String>{}.obs;

  Future<AdminAddProductTagModel> addTag(String tag) async {
    if (tags.map((e) => e.tag).toList().contains(tag)) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              '${LocaleKeys.tr_data_tag.tr} $tag ${LocaleKeys.error_data_already_exists.tr}')));
      throw Exception('Failed to add tag $tag: tag already exists.');
    }
    Either<Exception, AdminAddProductTagModel> zResponse =
        await client.addTag(AdminAddProductTagDTO(tag: tag));
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception('Failed to add tag $tag: Connection Error: $exception');
    }, (tagModel) {
      return tagModel;
    });
  }

  Future<dio.Response> deleteTag(int id) async {
    Either<Exception, dio.Response> zResponse = await client.deleteTag(id);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception('tag deletion failed: Connection Error: $exception');
    }, (response) {
      return response;
    });
  }

  Future<List<AdminAddProductTagModel>> getTags() async {
    Either<Exception, List<AdminAddProductTagModel>> zResponse =
        await client.getTagsList();
    return zResponse.fold((exception) {
      throw Exception(exception); //TODO: Handle tags retrieval failure
    }, (list) {
      return list;
    });
  }

  Future<AdminAddProductImageModel> uploadImage() async {
    AdminAddProductImageDTO dto = AdminAddProductImageDTO(
        image: productImagerHandler.imageFile.value!.readAsBytesSync());
    Either<Exception, AdminAddProductImageModel> zResponse =
        await client.uploadImage(dto);
    return zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Left(
          Exception('Failed to add Image: Connection Error: $exception'));
    }, (imageModel) {
      return imageModel;
    });
  }

  Future addProduct() async {
    int _imageID = 0;
    if (productImagerHandler.imageFile.value != null) {
      AdminAddProductImageModel imageModel = await uploadImage();
      _imageID = imageModel.id;
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(LocaleKeys.error_data_products_must_have_an_image.tr)));
      throw Exception('Product Image empty');
    }

    var dto = AdminAddProductDTO(
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text,
        tags: productTags.toList(),
        inStock: int.parse(inStockController.text),
        imageID: _imageID,
        isEnabled: isEnabled.value);
    Either<Exception, AdminAddProductModel> zResponse =
        await client.addProduct(dto);
    zResponse.fold((exception) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(LocaleKeys.error_data_connection_error.tr)));
      throw Exception(exception);
    }, (response) async {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
              '${LocaleKeys.tr_data_product.tr} ${nameController.text} ${LocaleKeys.tr_data_added.tr}.')));
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
    });
  }

  String? validator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    }
    return null;
  }

  String? inStockValidator(String? v) {
    if (v == null || v.isEmpty) {
      return LocaleKeys.error_data_field_can_not_be_empty.tr;
    } else if (int.parse(v) < 0) {
      return LocaleKeys.error_data_invalid_input_error.tr;
    }
    return null;
  }

  String? tagsValidator(String? tagsSet) {
    if (productTags.isEmpty) {
      return LocaleKeys.error_data_at_least_one_tag_should_be_specified.tr;
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
