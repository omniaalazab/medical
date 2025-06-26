class NotificationModel {
  final String id;
  final String message;
  final String? readAt;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.message,
    required this.readAt,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      message: json['data']['message'],
      readAt: json['read_at'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  bool get isRead => readAt != null;
}
