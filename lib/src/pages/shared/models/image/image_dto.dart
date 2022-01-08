import 'dart:typed_data';

class ImageDTO {
  Uint8List image;

  ImageDTO({required this.image});
  Map<String, dynamic> toMap() {
    return {
      'image': image,
    };
  }
}
