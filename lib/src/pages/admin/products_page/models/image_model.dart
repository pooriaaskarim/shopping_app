import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';

class ProductsPageImageModel extends ImageModel {
  ProductsPageImageModel({required int id, required Uint8List image})
      : super(id: id, image: image);

  factory ProductsPageImageModel.fromMap(Map<String, dynamic> jsonMap) {
    return ProductsPageImageModel(
      id: jsonMap['id'],
      image: Uint8List.fromList(jsonMap['image'].cast<int>()),
    );
  }
}
