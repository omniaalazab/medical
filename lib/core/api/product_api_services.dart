import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/core/models/product_model.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio});

  

  Future<dynamic> get( {required String endPoint}) async {
    final response = await dio.get('${Endpoints.baseUrl}$endPoint');
    if (response.statusCode == 200) {
    return response.data ;
    
  }}

  Future<ProductModel> fetchSingleProduct(int id) async {
    final response = await dio.get('${Endpoints.baseUrl}/products/$id');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return ProductModel.fromJson(data);
    } else {
      final error = response.data['message'] ?? 'Unknown server error';
      throw Exception('Failed to load product details: $error');
    }
  }
}
