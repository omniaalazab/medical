class ProductModel {
  final int? oldPrice;
  final int? newPrice;
  final String? imageUrl;
  final int id;
  final String? name;
  final String? description;
  final String? productionDate;
  final String? expiryDate;

  final bool isActive;
  final String? createdAt;
  final String? updatedAt;
  final Categories? category;
  // final Brand brand;
  // final Unit unit;
  final List<dynamic>?
  reviews; // We'll improve this later when review structure is clear
  final ReviewSummary reviewSummary;
  //  final List<Ingredient> ingredients;
  ProductModel({
    required this.oldPrice,
    required this.newPrice,

    required this.id,

    required this.name,
    required this.description,
    required this.productionDate,
    required this.expiryDate,
    required this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    // required this.brand,
    // required this.unit,
    required this.reviews,
    required this.reviewSummary,
    // required this.ingredients,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      productionDate: json['production_date'] ?? "",
      oldPrice: json['old_price'] ?? 0,
      newPrice: json['new_price'] ?? 0,
      expiryDate: json['expiry_date'] ?? "",
      imageUrl: json['image_url'] ?? "",
      isActive: json['is_active'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      category: Categories.fromJson(json['category']),
      // brand: Brand.fromJson(json['brand']),
      // unit: Unit.fromJson(json['unit']),
      reviews: json['reviews'] ?? [],
      reviewSummary: ReviewSummary.fromJson(json['review_summary']),
      //ingredients: (json['ingredients'] as List)
      // .map((e) => Ingredient.fromJson(e))
      // .toList(),
    );
  }
}

class Categories {
  final int id;
  final String name;
  final String? imageUrl;

  Categories({required this.id, required this.name, this.imageUrl});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}

class Brand {
  final int id;
  final String name;
  final String? logoUrl;

  Brand({required this.id, required this.name, this.logoUrl});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(id: json['id'], name: json['name'], logoUrl: json['logo_url']);
  }
}

class Unit {
  final int id;
  final String name;
  final String symbol;

  Unit({required this.id, required this.name, required this.symbol});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(id: json['id'], name: json['name'], symbol: json['symbol']);
  }
}

class ReviewSummary {
  final double averageRating;
  final int totalReviews;
  // final Ratings ratings;

  ReviewSummary({
    required this.averageRating,
    required this.totalReviews,
    // required this.ratings,
  });

  factory ReviewSummary.fromJson(Map<String, dynamic> json) {
    return ReviewSummary(
      averageRating: (json['average_rating'] as num).toDouble(),
      totalReviews: json['total_reviews'],
      // ratings: Ratings.fromJson(json['ratings']),
    );
  }
}

class Ratings {
  final int? fiveStar;
  final int? fourStar;
  final int? threeStar;
  final int? twoStar;
  final int? oneStar;

  Ratings({
    required this.fiveStar,
    required this.fourStar,
    required this.threeStar,
    required this.twoStar,
    required this.oneStar,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      fiveStar: json['5_star'] ?? 5,
      fourStar: json['4_star'] ?? 8,
      threeStar: json['3_star'] ?? 2,
      twoStar: json['2_star'] ?? 6,
      oneStar: json['1_star'] ?? 3,
    );
  }
}

class Ingredient {
  final int id;
  final String? name;
  final String? description;

  Ingredient({required this.id, required this.name, required this.description});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
