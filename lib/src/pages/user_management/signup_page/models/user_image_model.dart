import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_model.dart';

class UserImageModel extends ImageModel {
  UserImageModel({required id, required image}) : super(id: id, image: image);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory UserImageModel.fromMap(Map<String, dynamic> jsonMap) {
    return UserImageModel(
      id: jsonMap['id'] as int,
      image: Uint8List.fromList(jsonMap['image'].cast<int>()),
    );
  }
}
