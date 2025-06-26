import 'package:dartz/dartz.dart';
import 'package:medical/core/api/product_api_services.dart';
import 'package:medical/features/product_details/data/models/product_model.dart';

class ProductRepository {
  final ProductApiService apiService;

  ProductRepository(this.apiService);

  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      final products = await apiService.fetchAllProducts();
      return right(products);
    } catch (e) {
      return left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, ProductModel>> getProductById(int id) async {
    try {
      final product = await apiService.fetchSingleProduct(id);
      return right(product);
    } catch (e) {
      print(e);
      return left('Error: ${e.toString()}');
    }
  }
}
