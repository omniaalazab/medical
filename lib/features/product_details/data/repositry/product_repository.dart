import 'package:dartz/dartz.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/models/product_model.dart';
import 'package:medical/core/models/product_model/product_model.dart';

class ProductRepository {
  final ApiService apiService;

  ProductRepository(this.apiService);

  Future<Either<String, List<ProductUnifiedModel>>> getAllProducts() async {
    try {
      final products = await apiService.get(endPoint: Endpoints.products);
      return right(products);
    } catch (e) {
      return left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, ProductUnifiedModel>> getProductById(int id) async {
    try {
      final product = await apiService.fetchSingleProduct(id);
      return right(product);
    } catch (e) {
      print(e);
      return left('Error: ${e.toString()}');
    }
  }
}
