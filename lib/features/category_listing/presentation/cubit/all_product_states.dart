import 'package:medical/features/category_listing/data/models/all_product_model.dart';

abstract class AllProductState {}

class AllProductInitial extends AllProductState {}

class AllProductLoading extends AllProductState {}

class AllProductLoaded extends AllProductState {
  final List<AllProductModel> products;
  AllProductLoaded(this.products);
}

class AllProductError extends AllProductState {
  final String message;
  AllProductError(this.message);
}
