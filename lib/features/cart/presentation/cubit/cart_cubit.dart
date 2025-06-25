import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';
import 'package:medical/features/cart/data/repository/cart_repository.dart';
import 'package:medical/features/cart/presentation/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;

  CartCubit(this.repository) : super(CartInitial());

  void loadCart() {
    final items = repository.getCartItems();
    final total = repository.getTotalPrice();
    emit(CartUpdated(items, total));
  }

  void addItem(CartItemModel item) {
    repository.addToCart(item);
    loadCart();
  }

  void removeItem(int productId) {
    repository.removeFromCart(productId);
    loadCart();
  }

  void updateItemQuantity(int productId, int quantity) {
    repository.updateQuantity(productId, quantity);
    loadCart();
  }

  void clearCart() {
    repository.clearCart();
    loadCart();
  }
}
