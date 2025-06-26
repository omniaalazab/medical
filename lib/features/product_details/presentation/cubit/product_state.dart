import 'package:medical/features/product_details/data/models/product_model.dart';

class ProductStates {}

class ProductInitial extends ProductStates {}

class ProductLoading extends ProductStates {}

class ProductLoaded extends ProductStates {
  final ProductModel product;
  ProductLoaded({required this.product});
}

class ProductError extends ProductStates {
  final String message;
  ProductError({required this.message});
}
