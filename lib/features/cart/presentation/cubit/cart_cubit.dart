import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/cart/data/repository/cart_repository.dart';
import 'package:medical/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;
  CartCubit(this.repository) : super(CartInitial());

  Future<void> loadCart() async {
    try {
      emit(CartLoading()); // Add loading state
      await repository.fetchCart();
      final items = repository.getCartItems();
      final total = repository.getTotalPrice();
      emit(CartUpdated(items, total));
    } catch (e) {
      debugPrint("Error loading cart: $e");
      emit(CartError("Failed to load cart: ${e.toString()}"));
    }
  }

  Future<void> addItem(CartItemModel item) async {
    try {
      emit(CartLoading()); // Show loading while adding

      // Actually add the item to cart via API
      await repository.addToCart(item);

      // Get updated cart items and total
      final items = repository.getCartItems();
      final total = repository.getTotalPrice();

      debugPrint("****//////******success******////*****");
      debugPrint("Cart items count: ${items.length}");
      debugPrint("Cart total: $total");

      emit(CartUpdated(items, total));
    } catch (e) {
      debugPrint("Error adding to cart: $e");
      emit(CartError("Failed to add to cart: ${e.toString()}"));
    }
  }

  Future<void> removeItemFromCart(String cartId) async {
    try {
      await repository.removeItemCart(cartId);
      loadCart(); // Refresh cart
    } catch (e) {
      emit(CartError("Failed to remove item: $e"));
    }
  }

  Future<void> updateItemQuantity(int productId, int quantity) async {
    try {
      repository.updateQuantity(productId, quantity);
      await loadCart();
    } catch (e) {
      emit(CartError("Failed to update quantity"));
    }
  }

  Future<void> clearCart() async {
    try {
      repository.clearCart();
      await loadCart();
    } catch (e) {
      emit(CartError("Failed to clear cart"));
    }
  }
}
