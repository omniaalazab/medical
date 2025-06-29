import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/features/category_listing/data/models/all_product_model.dart';

class AllProductService {
  final Dio dio;
  AllProductService(this.dio);

  Future<List<AllProductModel>> getAllProducts() async {
    final response = await dio.get('${Endpoints.baseUrl}/products');
    final data = response.data['data'] as List;
    return data.map((json) => AllProductModel.fromJson(json)).toList();
  }
}
