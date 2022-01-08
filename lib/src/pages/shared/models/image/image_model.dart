import 'dart:typed_data';

class ImageModel {
  int id;
  Uint8List image;

  ImageModel({required this.id, required this.image});

  @override
  String toString() {
    return 'ImageModel{id: $id, image: $image}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'] as int,
      image: Uint8List.fromList(map['image'].cast<int>()),
    );
  }
}
