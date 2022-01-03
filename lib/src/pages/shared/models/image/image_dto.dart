import 'dart:typed_data';

abstract class ImageDTO {
  Uint8List image;

  ImageDTO({required this.image});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'image': image,
  //   };
  // }
  //
  // factory Image.fromMap(Map<String, dynamic> map) {
  //   return Image(
  //     image: map['image'] as Uint8List,
  //   );
  // }
}
