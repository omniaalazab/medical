class OtpResponse {
  final bool status;
  final String message;
  final OtpData? data;

  OtpResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
    );
  }
}


class OtpData {
  final String phone;
  final int expiresInMinutes;
  final bool isNewUser;

  OtpData({
    required this.phone,
    required this.expiresInMinutes,
    required this.isNewUser,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      phone: json['phone'] ?? '',
      expiresInMinutes: json['expires_in_minutes'] ?? 0,
      isNewUser: json['is_new_user'] ?? false,
    );
  }
}
