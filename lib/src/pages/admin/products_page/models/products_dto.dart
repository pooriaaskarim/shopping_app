class ProductDTO {
  late String name, description, price;
  late List<String> tags;
  late int inStock;
  late bool isEnabled;

  ProductDTO(this.name, this.description, this.price, this.tags, this.inStock,
      this.isEnabled);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'tags': tags,
      'inStock': inStock,
      'isEnabled': isEnabled,
    };
  }
}
