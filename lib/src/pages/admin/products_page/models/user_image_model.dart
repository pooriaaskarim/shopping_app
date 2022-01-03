import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';

class UserImageModel extends ImageModel {
  UserImageModel({required int id, required Uint8List image})
      : super(id: id, image: image);

  factory UserImageModel.fromMap(Map<String, dynamic> jsonMap) {
    return UserImageModel(
      id: jsonMap['id'],
      image: Uint8List.fromList(jsonMap['image'].cast<int>()),
    );
  }
}
