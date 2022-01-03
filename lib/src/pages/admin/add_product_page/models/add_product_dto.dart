import 'package:shopping_app/src/pages/shared/models/product/product_dto.dart';

class AdminAddProductDTO extends ProductDTO {
  AdminAddProductDTO(
      {required name,
      required description,
      required price,
      required tags,
      required inStock,
      required imageID,
      required isEnabled})
      : super(
            name: name,
            description: description,
            price: price,
            tags: tags,
            inStock: inStock,
            imageID: imageID,
            isEnabled: isEnabled);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'tags': tags,
      'inStock': inStock,
      'imageID': imageID,
      'isEnabled': isEnabled,
    };
  }

  factory AdminAddProductDTO.fromMap(Map<String, dynamic> map) {
    return AdminAddProductDTO(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      tags: map['tags'] as List<String>,
      inStock: map['inStock'] as int,
      imageID: map['imageID'] as int,
      isEnabled: map['isEnabled'] as bool,
    );
  }
}
