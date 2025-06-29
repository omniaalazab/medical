import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:medical/features/notification/cubit/notification_cubit.dart';
import 'package:medical/features/notification/cubit/notification_state.dart';
import 'package:medical/features/notification/data/model/notification_model.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';
import 'package:medical/features/notification/presentation/view/widgets/notification_listtile.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationRepository repository;
  final VoidCallback onBackPressed;

  const NotificationScreen({
    super.key,
    required this.repository,
    required this.onBackPressed,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<NotificationModel> notificationList = [
    NotificationModel(
      id: "1",
      message:
          'The future of professional learning is immersive, communal experiences for ',
      createdAt: DateTime.now(),
      readAt: DateTime.now().toString(),
    ),
    NotificationModel(
      id: "2",
      message: 'New 20% discount on diabetic care items this weekend!',
      createdAt: DateTime.now().subtract(Duration(days: 1, hours: 2)),
      readAt: DateTime.now().subtract(Duration(hours: 3)).toString(),
    ),
    NotificationModel(
      id: "3",
      message:
          'Reminder: Your prescription refill for Lipitor is due tomorrow.',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
      readAt: null,
    ),
  ];

  bool localCleared = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationCubit(widget.repository)..fetchNotifications(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            },
          ),
          title: Text(ConstantText.notifications, style: Styles.textStyle16),
          actions: [
            TextButton(
              onPressed: () {
                //  context.read<NotificationCubit>().clearAll();
                setState(() {
                  notificationList.clear(); // clear local list
                  localCleared = true; // trigger "no notifications yet"
                });
              },
              child: Text(ConstantText.clearAll, style: Styles.textStyle13),
            ),
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: localCleared
              ? Center(
                  child: Text(
                    'No notifications yet.',
                    style: Styles.textStyle14,
                  ),
                )
              : BlocBuilder<NotificationCubit, NotificationState>(
                  builder: (context, state) {
                    if (state is NotificationLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is NotificationLoaded) {
                      final notifications = state.notifications;
                      if (notifications.isEmpty) {
                        if (notificationList.isNotEmpty && !localCleared) {
                          return ListView.builder(
                            itemCount: notificationList.length,
                            itemBuilder: (context, index) {
                              final notification = notificationList[index];
                              return Card(
                                elevation: 0,
                                child: NotificationListTile(
                                  title: notification.message,
                                  subtitle: notification.createdAt.toString(),
                                  onTap: () {
                                    context
                                        .read<NotificationCubit>()
                                        .markAsRead(notification.id);
                                  },
                                  onDelete: () {
                                    context
                                        .read<NotificationCubit>()
                                        .deleteNotification(notification.id);
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          // Show empty state
                          return Center(
                            child: Text(
                              'No notifications yet.',
                              style: Styles.textStyle14,
                            ),
                          );
                        }
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
                                context.read<NotificationCubit>().markAsRead(
                                  notification.id,
                                );
                              },
                              onDelete: () {
                                context
                                    .read<NotificationCubit>()
                                    .deleteNotification(notification.id);
                              },
                            ),
                          );
                        },
                      );
                    } else if (state is NotificationError) {
                      return ListView.builder(
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          final notification = notificationList[index];
                          return Card(
                            elevation: 0,
                            child: NotificationListTile(
                              title: notification.message,
                              subtitle: notification.createdAt.toString(),
                              onTap: () {
                                context.read<NotificationCubit>().markAsRead(
                                  notification.id,
                                );
                              },
                              onDelete: () {
                                context
                                    .read<NotificationCubit>()
                                    .deleteNotification(notification.id);
                              },
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'No notifications yet.',
                          style: Styles.textStyle14,
                        ),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}
