class CartItemModel {
  final String id;
  final String productId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;

  int quantity;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,

    this.quantity = 1,
  });
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      title: title,
      productId: productId,
      subtitle: subtitle,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
