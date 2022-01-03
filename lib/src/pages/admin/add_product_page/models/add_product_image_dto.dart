import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';

class AdminAddProductImageDTO extends ImageDTO {
  AdminAddProductImageDTO({required Uint8List image}) : super(image: image);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  factory AdminAddProductImageDTO.fromMap(Map<String, dynamic> jsonMap) {
    return AdminAddProductImageDTO(
      image: jsonMap['image'].cast<int>(),
    );
  }
}
