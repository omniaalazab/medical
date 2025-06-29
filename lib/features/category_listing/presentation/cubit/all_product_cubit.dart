import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/category_listing/data/repository/all_product_repository.dart';
import 'package:medical/features/category_listing/presentation/cubit/all_product_states.dart';

class AllProductCubit extends Cubit<AllProductState> {
  final AllProductRepository repository;
  AllProductCubit(this.repository) : super(AllProductInitial());

  Future<void> getProducts() async {
    emit(AllProductLoading());
    try {
      final products = await repository.fetchProducts();
      emit(AllProductLoaded(products));
    } catch (e) {
      emit(AllProductError(e.toString()));
    }
  }
}
