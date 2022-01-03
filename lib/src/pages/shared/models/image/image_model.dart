import 'dart:typed_data';

abstract class ImageModel {
  int id;
  Uint8List image;

  ImageModel({required this.id, required this.image});

  @override
  String toString() {
    return 'ImageModel{id: $id, image: $image}';
  }

// Map<String, dynamic> toMap() {
//   return {
//     'id': id,
//     'image': image,
//   };
// }
//
// factory Image.fromMap(Map<String, dynamic> jsonMap) {
//   return Image(
//     id: jsonMap['id'] as int,
//     image: Uint8List.fromList(jsonMap['image'].cast<int>()),
//   );
// }
}
