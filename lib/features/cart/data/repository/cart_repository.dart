import 'package:medical/features/cart/data/models/cart_model.dart';

class CartRepository {
  final List<CartItemModel> _cart = [];

  List<CartItemModel> getCartItems() {
    return List.unmodifiable(_cart);
  }

  void addToCart(CartItemModel product) {
    final index = _cart.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      _cart[index].quantity += 1;
    } else {
      _cart.add(product);
    }
  }

  void removeFromCart(int productId) {
    _cart.removeWhere((item) => item.id == productId);
  }

  void updateQuantity(int productId, int quantity) {
    final index = _cart.indexWhere((item) => item.id == productId);
    if (index >= 0) {
      _cart[index] = _cart[index].copyWith(quantity: quantity);
    }
  }

  double getTotalPrice() {
    return _cart.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  void clearCart() {
    _cart.clear();
  }
}
