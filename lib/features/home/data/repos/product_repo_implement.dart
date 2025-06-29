import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medical/core/api/endpoints.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/features/home/data/repos/product_repo.dart';

class ProductRepoImplement extends ProductRepo {
  final ApiService _productApiService;

  ProductRepoImplement({required ApiService productApiService})
    : _productApiService = productApiService;
  @override
  Future<Either<Failure, List<ProductUnifiedModel>>> getProducts() async {
    try {
      var data = await _productApiService.get(endPoint: Endpoints.products);
      List<ProductUnifiedModel> products = [];
      for (var item in data['data']) {
        products.add(ProductUnifiedModel.fromJson(item));
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
