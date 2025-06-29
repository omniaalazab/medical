import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/features/category_listing/data/models/all_product_model.dart';

class SearchService {
  final Dio dio;

  SearchService(this.dio);

  Future<List<AllProductModel>> searchProducts(String query) async {
    final response = await dio.get(
      '${Endpoints.baseUrl}/products/advanced-search',
      queryParameters: {'q': query},
    );
    final List data = response.data['data']['data'];
    return data.map((e) => AllProductModel.fromJson(e)).toList();
  }
}
