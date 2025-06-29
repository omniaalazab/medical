import 'package:dartz/dartz.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/core/models/product_model/product_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<ProductUnifiedModel>>> fetchSearchResult({
    required String query,
  });
}
