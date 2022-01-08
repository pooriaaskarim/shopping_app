class ProductDTO {
  int imageID;
  String name, description, price;
  List<String> tags;
  int inStock;
  bool isEnabled;
  ProductDTO(
      {required this.name,
      required this.description,
      required this.price,
      required this.tags,
      required this.inStock,
      required this.imageID,
      required this.isEnabled});
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

  factory ProductDTO.fromMap(Map<String, dynamic> map) {
    return ProductDTO(
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
