import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.notifications_none_rounded),

      title: Text(title, style: Styles.textStyle14),
      subtitle: Text(
        subtitle,
        style: Styles.textStyle13.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
