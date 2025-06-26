import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/notification/cubit/notification_cubit.dart';
import 'package:medical/features/notification/cubit/notification_state.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:medical/features/notification/presentation/view/widgets/notification_listtile.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationRepository repository;
  final VoidCallback onBackPressed;

  const NotificationScreen({
    super.key,
    required this.repository,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(repository)..fetchNotifications(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: onBackPressed,
          ),
          title: Text(ConstantText.notifications, style: Styles.textStyle16),
          actions: [
            TextButton(
              onPressed: () {
                context.read<NotificationCubit>().markAllAsRead();
              },
              child: Text(ConstantText.clearAll, style: Styles.textStyle13),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NotificationLoaded) {
                final notifications = state.notifications;

                if (notifications.isEmpty) {
                  return const Center(child: Text('No notifications.'));
                }

                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Card(
                      elevation: 0,
                      child: NotificationListTile(
                        title: notification.message,
                        subtitle: notification.createdAt.toString(),
                        onTap: () {
                          context.read<NotificationCubit>().markAsRead(notification.id);
                        },
                        onDelete: () {
                          context.read<NotificationCubit>().deleteNotification(notification.id);
                        },
                      ),
                    );
                  },
                );
              } else if (state is NotificationError) {
                return Center(child: Text(state.message));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

