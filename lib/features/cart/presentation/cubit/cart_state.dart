import 'package:medical/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemModel> cartItems;
  final double total;

  CartUpdated(this.cartItems, this.total);
}

class CartError extends CartState {
  final String message;

  CartError(this.message);
}
