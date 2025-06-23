import 'package:flutter/material.dart';
import 'package:medical/core/constant_text.dart';
import 'package:medical/core/utils/styles.dart';
import 'package:medical/features/notification/presentation/view/widgets/notification_listtile.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {},
        ),
        title: Text(ConstantText.notifications, style: Styles.textStyle16),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(ConstantText.clearAll, style: Styles.textStyle13),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    child: NotificationListTile(
                      title:
                          "We know that — for children AND adults — learning is most effective when it is",
                      subtitle: "Aug 12, 2020 at 12:08 PM",
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
