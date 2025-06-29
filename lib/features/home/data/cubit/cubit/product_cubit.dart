import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/models/product_model/product_model.dart';
import 'package:medical/features/home/data/repos/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.productRepo) : super(ProductInitial());
  final ProductRepo productRepo;
  Future<void> fetchProducts() async {
    emit(ProductLoading());
    final result = await productRepo.getProducts();
    result.fold(
      (failure) => emit(ProductError(message: failure.errorMessage)),
      (products) => emit(ProductSuccess(products: products)),
    );
  }
}
