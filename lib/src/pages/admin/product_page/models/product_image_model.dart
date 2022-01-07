import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';

class AdminProductImageModel extends ImageModel {
  AdminProductImageModel({required id, required Uint8List image})
      : super(id: id, image: image);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory AdminProductImageModel.fromMap(Map<String, dynamic> map) {
    return AdminProductImageModel(
      id: map['id'] as int,
      image: Uint8List.fromList(map['image'].cast<int>()),
    );
  }
}
