import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/search/presentation/views/widgets/search_view_body.dart';

import '../../data/repo/search_repo_implement.dart';
import '../view_model/search_cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   // child: BlocProvider(
      //   //   create: (BuildContext context) =>
      //   //       SearchCubit(SearchRepoImplement()),
      //   //   child: const SearchViewBody(),
      //   // ),
      // ),
    );
  }
}
