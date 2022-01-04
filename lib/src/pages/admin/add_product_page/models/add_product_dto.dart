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
      name: map['name'],
      description: map['description'],
      price: map['price'],
      tags: map['tags'].cast<String>(),
      inStock: map['inStock'],
      imageID: map['imageID'],
      isEnabled: map['isEnabled'],
    );
  }
}
