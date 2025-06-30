import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/home/presentation/view/home.dart';
import 'package:medical/features/notification/data/model/notification_model.dart';
import 'package:medical/features/notification/presentation/view/widgets/notification_listtile.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
          },
        ),
        title: Text(ConstantText.notifications, style: Styles.textStyle16),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                notificationList.clear(); // Clear local notifications
              });
            },
            child: Text(ConstantText.clearAll, style: Styles.textStyle13),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: notificationList.isEmpty
            ? Center(
                child: Text('No notifications yet.', style: Styles.textStyle14),
              )
            : ListView.builder(
                itemCount: notificationList.length,
                itemBuilder: (context, index) {
                  final notification = notificationList[index];
                  return Card(
                    elevation: 0,
                    child: NotificationListTile(
                      title: notification.message,
                      subtitle: notification.createdAt.toString(),
                      onTap: () {
                        // Optional: mark as read locally
                      },
                      onDelete: () {
                        setState(() {
                          notificationList.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
