class ProductModel {
  int id, imageID;
  String name, description, price;
  List<String> tags;
  int inStock;
  bool isEnabled;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.tags,
      required this.inStock,
      required this.imageID,
      required this.isEnabled});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'price': price,
//       'tags': tags,
//       'inStock': inStock,
//       'imageID': imageID,
//       'isEnabled': isEnabled,
//     };
//   }
//
//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     return ProductModel(
//       id: map['id'] as int,
//       name: map['name'] as String,
//       description: map['description'] as String,
//       price: map['price'] as String,
//       tags: map['tags'] as List<String>,
//       inStock: map['inStock'] as int,
//       imageID: map['imageID'] as int,
//       isEnabled: map['isEnabled'] as bool,
//     );
// }
}
