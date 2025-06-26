import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/product_details/data/repositry/product_repository.dart';
import 'package:medical/features/product_details/presentation/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductStates> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());

  // Future<void> fetchProducts() async {
  //   emit(ProductLoading());
  //   final result = await repository.getAllProducts();
  //   result.fold(
  //     (failure) => emit(ProductError(failure)),
  //     (products) => emit(ProductLoaded(products)),
  //   );
  // }

  Future<void> fetchProductById(int id) async {
    emit(ProductLoading());
    final result = await repository.getProductById(id);
    result.fold(
      (failure) => emit(ProductError(message: failure)),
      (product) => emit(ProductLoaded(product: product)),
    );
  }
}
