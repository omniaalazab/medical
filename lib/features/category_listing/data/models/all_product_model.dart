class AllProductModel {
  final int id;
  final String name;
  final String description;
  final int rating;
  final double newPrice;
  final double oldPrice;
  final int quantity;
  final String? imageUrl;
  final Category category;
  final Brand brand;
  final Unit unit;

  AllProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.newPrice,
    required this.oldPrice,
    required this.rating,
    required this.quantity,
    required this.imageUrl,
    required this.category,
    required this.brand,
    required this.unit,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) {
    return AllProductModel(
      id: json['id'],
      rating: json['average_rating'],
      name: json['name'],
      description: json['description'],
      newPrice: json['new_price'].toDouble(),
      oldPrice: json['old_price'].toDouble(),
      quantity: json['quantity'],
      imageUrl: json['image_url'],
      category: Category.fromJson(json['category']),
      brand: Brand.fromJson(json['brand']),
      unit: Unit.fromJson(json['unit']),
    );
  }
}

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class Brand {
  final int id;
  final String name;

  Brand({required this.id, required this.name});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json['id'], name: json['name']);
  }
}

class Unit {
  final int id;
  final String name;

  Unit({required this.id, required this.name});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(id: json['id'], name: json['name']);
  }
}
