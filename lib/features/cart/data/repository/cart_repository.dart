import 'package:medical/features/cart/data/api_services/cart_api_services.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';

class CartRepository {
  final CartAPIServices apiService;

  List<CartItemModel> _cartItems = [];
  final double _total = 0;

  CartRepository(this.apiService);

  List<CartItemModel> getCartItems() => _cartItems;

  double getTotalPrice() {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + item.price * item.quantity,
    );
  }

  Future<void> addToCart(CartItemModel item) async {
    final updatedCart = await apiService.addToCart(
      productId: item.productId,
      quantity: item.quantity,
    );
    _cartItems = updatedCart;
  }

  Future<void> fetchCart() async {
    _cartItems = await apiService.getCart();
  }

  Future<void> removeItemCart(String cartId) async {
    await apiService.removeItemCart(cartId);
    _cartItems.removeWhere((item) => item.id == cartId);
  }

  void updateQuantity(int productId, int quantity) {
    final index = _cartItems.indexWhere(
      (item) => int.parse(item.productId) == productId,
    );
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }
}
