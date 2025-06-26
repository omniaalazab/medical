class AddressModel {
  final String id;
  final String title;
  final String addressLine1;
  final String addressLine2;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    this.isDefault = false,
  });
  AddressModel copyWith({
    String? title,
    String? addressLine1,
    String? addressLine2,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id,
      title: title ?? this.title,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
