import 'package:medical/features/notification/data/api/api_services_notification.dart';

import '../model/notification_model.dart';

class NotificationRepository {
  final NotificationService service;

  NotificationRepository(this.service);

  Future<List<NotificationModel>> getNotifications() {
    return service.getNotifications();
  }

  Future<void> deleteNotification(String id) {
    return service.deleteNotification(id);
  }

  Future<void> markAsRead(String id) {
    return service.markAsRead(id);
  }

  Future<void> markAllAsRead() {
    return service.markAllAsRead();
  }
}
