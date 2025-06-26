
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medical/core/api/product_api_services.dart';
import 'package:medical/core/errors/failure.dart' show Failure, ServerFailure;
import 'package:medical/core/models/product_model.dart';
import 'package:medical/features/search/data/repo/search_repo.dart';

class SearchRepoImplement extends SearchRepo {
  final ApiService _apiService;

  SearchRepoImplement({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Either<Failure, List<ProductModel>>> fetchSearchResult(
      {required String query}) async {
    try {
      var data = await _apiService.get(
          endPoint: "&filtering=free_ebooks&Sorting=relevance" );
      List<ProductModel> searchBooks = [];
      for (var item in data['items']) {
        searchBooks.add(ProductModel.fromJson(item));
      }
      return right(searchBooks);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
