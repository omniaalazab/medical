import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/api/api_services.dart';
import 'package:medical/core/api_constant.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:medical/features/profile/data/repos/profile_repo_implement.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_cubit.dart';
import 'package:medical/features/profile/presentation/cubit/cubit/profile_info_state.dart';
import 'package:medical/features/profile/presentation/views/update_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
            ),
            title: const Text('My Profile'),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        state is ProfileInfoSuccess
                            ? state.userProfile.profileImageUrl ??
                                  APIKey.networkImage
                            : APIKey.networkImage,
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, ${state is ProfileInfoSuccess ? state.userProfile.firstName : 'User'} ${state is ProfileInfoSuccess ? state.userProfile.lastName : ''}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Welcome to Nilkanth Medical Store',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                buildListTile(
                  icon: Icons.edit,
                  title: 'Edit Profile',
                  onTap: () {
                    print('Edit Profile tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => ProfileInfoCubit(
                              ProfileRepoImplement(
                                apiService: ApiService(dio: Dio()),
                              ),
                            ),
                            child: const UpdateProfileScreen(),
                          );
                        },
                      ),
                    );

                    setState(() {});
                  },
                ),
                buildListTile(
                  icon: Icons.access_alarm_rounded,
                  title: 'My orders',
                ),
                buildListTile(icon: Icons.credit_card, title: 'Billing'),
                buildListTile(icon: Icons.help_outline, title: 'Faq'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildListTile({
    required IconData icon,
    required String title,
    Function()? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icon, color: Colors.blue),
            title: Text(title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: onTap,
          ),
        ),
        const Divider(height: 0),
      ],
    );
  }
}
