import 'data.dart';

class UserProfile {
  String? status;
  String? message;
  Data? data;

  UserProfile({this.status, this.message, this.data});

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    status: json['status'] as String?,
    message: json['message'] as String?,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}
