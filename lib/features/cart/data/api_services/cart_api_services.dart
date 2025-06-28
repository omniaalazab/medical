import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/features/cart/data/models/cart_model.dart';

class CartAPIServices {
  Dio dio;
  CartAPIServices({required this.dio});

  // Helper method to get headers with authentication
  Map<String, dynamic> _getHeaders() {
    return {
      'Authorization':
          'Bearer 1|E2pejsYto9qBOH9vwBqpfulKGFYHR0G98A2fQmxy01cbba53',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<List<CartItemModel>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      debugPrint("=== Add to Cart API Call ===");
      debugPrint("URL: ${Endpoints.baseUrl}/cart/add");
      debugPrint("Product ID: $productId");
      debugPrint("Quantity: $quantity");
      debugPrint("Headers: ${_getHeaders()}");

      final response = await dio.post(
        "${Endpoints.baseUrl}/cart/add",
        data: {
          "product_id":
              int.tryParse(productId) ?? productId, // Try both int and string
          "quantity": quantity,
        },
        options: Options(
          headers: _getHeaders(),
          validateStatus: (status) => status! < 500,
        ),
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          // Handle different response structures
          if (response.data['cart'] != null) {
            final List<dynamic> cartItems = response.data['cart'];
            return cartItems
                .map((json) => CartItemModel.fromJson(json))
                .toList();
          } else if (response.data['data'] != null &&
              response.data['data']['cart'] != null) {
            final List<dynamic> cartItems = response.data['data']['cart'];
            return cartItems
                .map((json) => CartItemModel.fromJson(json))
                .toList();
          } else if (response.data is List) {
            final List<dynamic> cartItems = response.data;
            return cartItems
                .map((json) => CartItemModel.fromJson(json))
                .toList();
          } else {
            debugPrint("Unexpected response structure: ${response.data}");
            // If we can't parse the response, at least fetch the current cart
            try {
              return await getCart();
            } catch (e) {
              return <CartItemModel>[];
            }
          }
        } else {
          throw Exception("Empty response from server");
        }
      } else if (response.statusCode == 401) {
        throw Exception("Authentication failed. Please check your token.");
      } else if (response.statusCode == 422) {
        final errors =
            response.data['errors'] ??
            response.data['message'] ??
            'Validation failed';
        throw Exception("Validation error: $errors");
      } else {
        final errorMessage =
            response.data['message'] ?? 'Failed to add item to cart';
        throw Exception("Server error (${response.statusCode}): $errorMessage");
      }
    } on DioException catch (e) {
      debugPrint("=== Dio Exception ===");
      debugPrint("Type: ${e.type}");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");
      debugPrint("Status Code: ${e.response?.statusCode}");

      if (e.response?.statusCode == 500) {
        final serverError =
            e.response?.data['error'] ??
            e.response?.data['message'] ??
            'Internal server error - please check server logs';
        throw Exception("Server error: $serverError");
      } else if (e.response?.statusCode == 401) {
        throw Exception("Authentication failed. Token may be expired.");
      } else if (e.response?.statusCode == 422) {
        final errors =
            e.response?.data['errors'] ??
            e.response?.data['message'] ??
            'Validation failed';
        throw Exception("Validation error: $errors");
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
          "Connection timeout. Please check your internet connection.",
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Server response timeout. Please try again.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      debugPrint("=== General Exception ===");
      debugPrint("Error: $e");
      throw Exception("Failed to add item to cart: $e");
    }
  }

  Future<List<CartItemModel>> getCart() async {
    try {
      debugPrint("=== Get Cart API Call ===");
      debugPrint("URL: ${Endpoints.baseUrl}/cart");
      debugPrint("Headers: ${_getHeaders()}");

      final response = await dio.get(
        "${Endpoints.baseUrl}/cart",
        options: Options(
          headers: _getHeaders(),
          validateStatus: (status) => status! < 500,
        ),
      );

      debugPrint("Response Status: ${response.statusCode}");
      debugPrint("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data != null) {
          // Handle different response structures
          if (response.data['cart'] != null) {
            final List<dynamic> cart = response.data['cart'];
            return cart.map((item) => CartItemModel.fromJson(item)).toList();
          } else if (response.data['data'] != null &&
              response.data['data']['cart'] != null) {
            final List<dynamic> cart = response.data['data']['cart'];
            return cart.map((item) => CartItemModel.fromJson(item)).toList();
          } else if (response.data is List) {
            final List<dynamic> cart = response.data;
            return cart.map((item) => CartItemModel.fromJson(item)).toList();
          } else {
            debugPrint("Cart is empty or unexpected structure");
            return <CartItemModel>[];
          }
        } else {
          debugPrint("Empty response - cart is empty");
          return <CartItemModel>[];
        }
      } else if (response.statusCode == 401) {
        throw Exception("Authentication failed. Please check your token.");
      } else {
        final errorMessage = response.data['message'] ?? 'Failed to load cart';
        throw Exception("Server error (${response.statusCode}): $errorMessage");
      }
    } on DioException catch (e) {
      debugPrint("=== Dio Exception (Get Cart) ===");
      debugPrint("Type: ${e.type}");
      debugPrint("Message: ${e.message}");
      debugPrint("Response: ${e.response?.data}");
      debugPrint("Status Code: ${e.response?.statusCode}");

      if (e.response?.statusCode == 500) {
        final serverError =
            e.response?.data['error'] ??
            e.response?.data['message'] ??
            'Internal server error';
        throw Exception("Server error: $serverError");
      } else if (e.response?.statusCode == 401) {
        throw Exception("Authentication failed. Token may be expired.");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      debugPrint("=== General Exception (Get Cart) ===");
      debugPrint("Error: $e");
      throw Exception("Failed to load cart: $e");
    }
  }

  Future<void> removeItemCart(String cartId) async {
    final response = await dio.delete(
      "${Endpoints.baseUrl}/cart/remove/$cartId",
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to remove item from cart");
    }
  }
}
