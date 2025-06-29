import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/category_listing/data/models/all_product_model.dart';
import 'package:medical/features/home/data/repos/search_repo.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<AllProductModel> results;
  SearchSuccess(this.results);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;

  SearchCubit(this.repository) : super(SearchInitial());

  Future<void> search(String query) async {
    if (query.isEmpty) return;
    emit(SearchLoading());
    try {
      final results = await repository.search(query);
      debugPrint("✅ Search result count: ${results.length}");
      emit(SearchSuccess(results));
    } catch (e) {
      debugPrint("❌ Search error: $e");
      emit(SearchError(e.toString()));
    }
  }
}
