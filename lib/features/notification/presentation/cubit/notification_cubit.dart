import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medical/features/notification/presentation/cubit/notification_state.dart';
import 'package:medical/features/notification/data/repository/notification_repository.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository repository;

  NotificationCubit(this.repository) : super(NotificationInitial());

  void fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final notifications = await repository.getNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError('Error loading notifications'));
    }
  }

  void deleteNotification(String id) async {
    try {
      await repository.deleteNotification(id);
      fetchNotifications();
    } catch (e) {
      emit(NotificationError('Error while deleting'));
    }
  }

  void markAsRead(String id) async {
    try {
      await repository.markAsRead(id);
      fetchNotifications();
    } catch (e) {
      emit(NotificationError('Error while marking as read'));
    }
  }

  void markAllAsRead() async {
    try {
      await repository.markAllAsRead();
      fetchNotifications();
    } catch (e) {
      emit(NotificationError('Error while marking as readable to all'));
    }
  }
}
