import 'package:dio/dio.dart';
import 'package:medical/core/api/api_services.dart';
import '../model/notification_model.dart';

class NotificationRepository {
  final Dio dio;

  NotificationRepository(ApiService apiService, {required this.dio});

  Future<List<NotificationModel>> getNotifications() async {
    try {
      final response = await dio.get('/notifications');
      final List data = response.data['data']['notifications'];
      return data.map((e) => NotificationModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      await dio.delete('/notifications/$id');
    } catch (e) {
      throw Exception('Failed to delete notification');
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await dio.post('/notifications/$id/read');
    } catch (e) {
      throw Exception('Failed to mark notification as read');
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await dio.post('/notifications/mark-all-as-read');
    } catch (e) {
      throw Exception('Failed to mark all notifications as read');
    }
  }
}
