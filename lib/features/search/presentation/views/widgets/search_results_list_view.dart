import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical/core/widgets/custom_progress_indicator.dart';
import 'package:medical/features/search/presentation/view_model/search_cubit/search_cubit.dart';
import 'package:medical/features/search/presentation/view_model/search_cubit/search_states.dart';

class SearchResultsListView extends StatelessWidget {
  const SearchResultsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        if (state is SearchSuccessState) {
          if (state.searchBooks.isEmpty) {
            return const Center(child: Text("Not Data yet"));
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.searchBooks.length,
            itemBuilder: (context, index) {
              // return Padding(
              //   padding: EdgeInsets.symmetric(
              //     vertical: 8.sp,
              //   ),
              //   child:
              // );
            },
          );
        } else if (state is SearchFailureState) {
          // return CustomFailure(errorMessage: state.errMessage);
        } else if (state is SearchLoadingState) {
          return const CustomProgressIndicator();
        }
        return const Center(child: Text("Not Data yet"));
      },
    );
  }
}
