import 'package:dartz/dartz.dart';
import 'package:medical/core/errors/failure.dart';
import 'package:medical/core/models/product_model.dart';

abstract class ProductRepo {
  Future<Either<Failure, List<ProductModel>>> getProducts();
}
