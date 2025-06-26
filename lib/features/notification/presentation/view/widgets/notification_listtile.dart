import 'package:flutter/material.dart';
import 'package:medical/core/utils/styles.dart';

class NotificationListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const NotificationListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications_none_rounded),
      title: Text(title, style: Styles.textStyle14),
      subtitle: Text(
        subtitle,
        style: Styles.textStyle13.copyWith(fontWeight: FontWeight.w400),
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: onDelete,
      ),
    );
  }
}
