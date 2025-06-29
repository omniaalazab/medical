import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/features/search/data/repo/search_repo.dart';

class SearchRepoImplement extends SearchRepo {
  final ApiService _apiService;

  SearchRepoImplement({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<Either<Failure, List<ProductUnifiedModel>>> fetchSearchResult({
    required String query,
  }) async {
    try {
      var data = await _apiService.get(endPoint: Endpoints.search);
      List<ProductUnifiedModel> searchBooks = [];
      for (var item in data['items']) {
        searchBooks.add(ProductUnifiedModel.fromJson(item));
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
