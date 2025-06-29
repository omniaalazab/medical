
import 'package:medical/core/models/product_model/product_model.dart';

class SearchStates {
  const SearchStates();
}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final List<ProductUnifiedModel> searchBooks;

  const SearchSuccessState({required this.searchBooks});
}

class SearchFailureState extends SearchStates {
  final String errMessage;

  const SearchFailureState({required this.errMessage});
}
