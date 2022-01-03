import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';

class AdminProductImageDTO extends ImageDTO {
  AdminProductImageDTO({required Uint8List image}) : super(image: image);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  factory AdminProductImageDTO.fromMap(Map<String, dynamic> jsonMap) {
    return AdminProductImageDTO(
      image: jsonMap['image'].cast<int>(),
    );
  }
}
