class CartItemModel {
  final String id;
  final String productId;

  final String imageUrl;
  final double price;

  int quantity;
  CartItemModel({
    required this.id,
    required this.productId,

    required this.imageUrl,
    required this.price,

    this.quantity = 1,
  });
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,

      productId: productId,

      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'].toString(),
      productId: json['product_id'].toString(),
      imageUrl: json['image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {'product_id': productId, 'quantity': quantity};
  }
}
