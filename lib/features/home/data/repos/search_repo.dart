import 'package:medical/features/category_listing/data/models/all_product_model.dart';
import 'package:medical/features/home/data/search_api_service/search_api_services.dart';

class SearchRepository {
  final SearchService service;

  SearchRepository(this.service);

  Future<List<AllProductModel>> search(String query) {
    return service.searchProducts(query);
  }
}
