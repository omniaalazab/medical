import 'package:dio/dio.dart';
import 'package:medical/features/product_details/data/models/product_model.dart';

class ProductApiService {
  final Dio dio;

  ProductApiService({required this.dio});

  static const String baseUrl =
      'https://medical.digital-vision-solutions.com/api';

  Future<List<ProductModel>> fetchAllProducts() async {
    final response = await dio.get('$baseUrl/products');

    if (response.statusCode == 200) {
      final data = response.data['data'] as List;
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductModel> fetchSingleProduct(int id) async {
    final response = await dio.get('$baseUrl/products/$id');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return ProductModel.fromJson(data);
    } else {
      final error = response.data['message'] ?? 'Unknown server error';
      throw Exception('Failed to load product details: $error');
    }
  }
}
