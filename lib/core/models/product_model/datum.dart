import 'brand.dart';
import 'category.dart';
import 'unit.dart';

class Datum {
  int? id;
  String? name;
  String? description;
  int? newPrice;
  int? oldPrice;
  int? quantity;
  dynamic barcode;
  String? imageUrl;
  dynamic productionDate;
  dynamic expiryDate;
  bool? isActive;
  int? averageRating;
  int? reviewsCount;
  Category? category;
  Brand? brand;
  Unit? unit;
  List<dynamic>? ingredients;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.description,
    this.newPrice,
    this.oldPrice,
    this.quantity,
    this.barcode,
    this.imageUrl,
    this.productionDate,
    this.expiryDate,
    this.isActive,
    this.averageRating,
    this.reviewsCount,
    this.category,
    this.brand,
    this.unit,
    this.ingredients,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    newPrice: json['new_price'] as int?,
    oldPrice: json['old_price'] as int?,
    quantity: json['quantity'] as int?,
    barcode: json['barcode'] as dynamic,
    imageUrl: json['image_url'] as String?,
    productionDate: json['production_date'] as dynamic,
    expiryDate: json['expiry_date'] as dynamic,
    isActive: json['is_active'] as bool?,
    averageRating: json['average_rating'] as int?,
    reviewsCount: json['reviews_count'] as int?,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    brand: json['brand'] == null
        ? null
        : Brand.fromJson(json['brand'] as Map<String, dynamic>),
    unit: json['unit'] == null
        ? null
        : Unit.fromJson(json['unit'] as Map<String, dynamic>),
    ingredients: json['ingredients'] as List<dynamic>?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'new_price': newPrice,
    'old_price': oldPrice,
    'quantity': quantity,
    'barcode': barcode,
    'image_url': imageUrl,
    'production_date': productionDate,
    'expiry_date': expiryDate,
    'is_active': isActive,
    'average_rating': averageRating,
    'reviews_count': reviewsCount,
    'category': category?.toJson(),
    'brand': brand?.toJson(),
    'unit': unit?.toJson(),
    'ingredients': ingredients,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
