// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medical/features/search/data/repo/search_repo.dart';
// import 'package:medical/features/search/presentation/view_model/search_cubit/search_states.dart'
//     show
//         SearchLoadingState,
//         SearchStates,
//         SearchInitialState,
//         SearchFailureState,
//         SearchSuccessState;

// class SearchCubit extends Cubit<SearchStates> {
//   SearchCubit(this.searchRepo) : super(SearchInitialState());
//   final SearchRepo searchRepo;
//   Future<void> fetchResultSearch({required String productName}) async {
//     emit(SearchLoadingState());
//     var result = await searchRepo.fetchSearchResult(
//       query: productName.toLowerCase(),
//     );
//     result.fold(
//       (failur) {
//         emit(SearchFailureState(errMessage: failur.errorMessage));
//       },
//       (books) {
//         emit(SearchSuccessState(searchBooks: books));
//       },
//     );
//   }
// }
