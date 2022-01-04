import 'package:shopping_app/src/pages/shared/models/product/product_model.dart';

class AdminAddProductModel extends ProductModel {
  AdminAddProductModel(
      {required id,
      required name,
      required description,
      required price,
      required tags,
      required inStock,
      required imageID,
      required isEnabled})
      : super(
            id: id,
            name: name,
            description: description,
            price: price,
            tags: tags,
            inStock: inStock,
            imageID: imageID,
            isEnabled: isEnabled);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'tags': tags,
      'inStock': inStock,
      'imageID': imageID,
      'isEnabled': isEnabled,
    };
  }

  factory AdminAddProductModel.fromMap(Map<String, dynamic> map) {
    return AdminAddProductModel(
      id: map['id'],
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
