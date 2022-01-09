class CartItemModel {
  int productID, count;

  CartItemModel({required this.productID, required this.count});

  Map<String, dynamic> toMap() {
    return {
      'productID': productID,
      'count': count,
    };
  }

  @override
  String toString() {
    return 'CartItemModel{productID: $productID, count: $count}';
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productID: map['productID'],
      count: map['count'],
    );
  }
}
