import 'package:medical/core/models/product_model/product_model.dart';

class ProductStates {}

class ProductInitial extends ProductStates {}

class ProductLoading extends ProductStates {}

class ProductSucces extends ProductStates {
  final ProductUnifiedModel product;
  ProductSucces({required this.product});
}

class ProductError extends ProductStates {
  final String message;
  ProductError({required this.message});
}
