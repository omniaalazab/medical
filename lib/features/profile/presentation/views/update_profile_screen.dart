import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/core/widgets/custom_elevated_button.dart';
import 'package:medical/features/profile/data/model/user_profile/data.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_cubit.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_state.dart';
import 'package:medical/features/profile/presentation/views/widgets/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileInfoCubit, ProfileInfoState>(
      listener: (BuildContext context, ProfileInfoState state) {
        if (state is ProfileInfoUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ProfileInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<ProfileInfoCubit>(context);
        return ModalProgressHUD(
          inAsyncCall: state is ProfileInfoLoading,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text('Update Profile'),
              backgroundColor: Colors.white,
            ),
            body: Form(
              key: cubit.formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(APIKey.networkImage),
                  ),
                  SizedBox(height: 6.0.h),
                  CustomTextFromField(
                    controller: cubit.firstNameController,
                    hintText: 'FirstName',
                    keyboardType: TextInputType.name,
                    onChange: (value) {},
                    obscre: false,
                    preIcone: const Icon(Icons.person),
                  ),
                  SizedBox(height: 3.0.h),
                  CustomTextFromField(
                    controller: cubit.lastNameController,
                    hintText: 'LastName',
                    keyboardType: TextInputType.name,
                    onChange: (value) {},
                    obscre: false,
                    preIcone: const Icon(Icons.person),
                  ),
                  SizedBox(height: 3.0.h),
                  CustomTextFromField(
                    controller: cubit.dateOfBirthController,
                    hintText: 'Date of Birth',
                    keyboardType: TextInputType.datetime,
                    onChange: (value) {},
                    obscre: false,
                    preIcone: const Icon(Icons.date_range),
                  ),
                  SizedBox(height: 3.0.h),
                  DropdownButtonFormField<String>(
                    value: cubit.genderController,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    items: const [
                      DropdownMenuItem(value: 'male', child: Text('male')),
                      DropdownMenuItem(value: 'female', child: Text('female')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProfileInfoCubit>().genderController =
                            value;
                      }
                    },
                  ),
                  SizedBox(height: 3.0.h),
                  CustomTextFromField(
                    controller: context.read<ProfileInfoCubit>().bioController,
                    hintText: 'bio',

                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 10.h),
                  CustomElevatedButton(
                    buttonText: 'Submit',
                    onPressedFunction: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.updateProfileData(
                          userProfile: Data(
                            firstName: cubit.firstNameController.text,
                            lastName: cubit.lastNameController.text,
                            dateOfBirth: cubit.dateOfBirthController.text,
                            gender: cubit.genderController,
                            bio: cubit.bioController.text,
                            profileImage: APIKey.networkImage,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
