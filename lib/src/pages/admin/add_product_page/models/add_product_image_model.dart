import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';

class AdminAddProductImageModel extends ImageModel {
  AdminAddProductImageModel({required id, required Uint8List image})
      : super(id: id, image: image);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory AdminAddProductImageModel.fromMap(Map<String, dynamic> map) {
    return AdminAddProductImageModel(
      id: map['id'] as int,
      image: map['image'].cast<int>(),
    );
  }
}
