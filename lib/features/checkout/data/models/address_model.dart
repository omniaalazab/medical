class AddressModel {
  final int id;
  final String title;
  final String addressLine1;
  final String addressLine2;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      title: json['title'],
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      // Convert int to bool (1 = true, 0 = false)
      isDefault: json['is_default'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      // Convert bool to int for API
      'is_default': isDefault ? 1 : 0,
    };
  }

  // Method for creating a copy with updated fields
  AddressModel copyWith({
    int? id,
    String? title,
    String? addressLine1,
    String? addressLine2,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      title: title ?? this.title,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  // Fixed method - ensure is_default is never null
  Map<String, dynamic> toCreateJson() {
    return {
      'title': title,
      'addressLine1': addressLine1, // camelCase for requests
      'addressLine2': addressLine2, // camelCase for requests
      'is_default': isDefault ? 1 : 0,
    };
  }

  // Add this method specifically for updates to ensure all fields are present
  Map<String, dynamic> toUpdateJson() {
    return {
      'title': title,
      'addressLine1': addressLine1, // camelCase for requests
      'addressLine2': addressLine2, // camelCase for requests
      'is_default': isDefault ? 1 : 0,
    };
  }
}
