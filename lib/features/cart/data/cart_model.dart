class CartItemModel {
  final String id;
  final String productId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final double originalPrice;
  int quantity;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    this.quantity = 1,
  });
}
