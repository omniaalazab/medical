import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        // BlocProvider.of<SearchCubit>(context)
        //     .fetchResultSearch(bookName: value);
      },
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.search, size: 18.sp),
        disabledBorder: customOutlineBorder(),
        focusedBorder: customOutlineBorder(),
        enabledBorder: customOutlineBorder(),
      ),
    );
  }

  OutlineInputBorder customOutlineBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(12.sp),
    );
  }
}
