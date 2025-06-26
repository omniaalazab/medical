import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/search/presentation/views/widgets/custom_text_field.dart';
import 'package:medical/features/search/presentation/views/widgets/search_results_list_view.dart';


class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Column(
                children: [
                  const CustomSearchTextField(),
                  SizedBox(
                    height: 40.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search Results",
                      style: Styles.textStyle18,
                    ),
                  ),
                ],
              ),
            ),
          ),
         const SliverFillRemaining(child:  SearchResultsListView()),
        ],
      ),
    );
  }
}
