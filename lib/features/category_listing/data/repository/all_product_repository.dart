import 'package:medical/features/category_listing/data/api/all_product_service_api.dart';
import 'package:medical/features/category_listing/data/models/all_product_model.dart';

class AllProductRepository {
  final AllProductService productService;
  AllProductRepository(this.productService);

  Future<List<AllProductModel>> fetchProducts() {
    return productService.getAllProducts();
  }
}
