class ProductModel {
  final String id;
  final String productName;
  final String productDescription;
  final int oldPrice;
  final int newPrice;
  final String imageUrl;
  ProductModel({
    required this.productName,
    required this.productDescription,
    required this.oldPrice,
    required this.newPrice,
    required this.imageUrl,
    required this.id,
  });
}
