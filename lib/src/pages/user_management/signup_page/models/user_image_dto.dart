import 'dart:typed_data';

import 'package:shopping_app/src/pages/shared/models/image/image_dto.dart';

class UserImageDTO extends ImageDTO {
  UserImageDTO({required Uint8List image}) : super(image: image);

  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }

  // factory UserImageDTO.fromMap(Map<String, dynamic> map) {
  //   return UserImageDTO(
  //     image: map['image'],
  //   );
  // }
}
