class User {
  int? id;
  String? name;
  String? phone;

  User({this.id, this.name, this.phone});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'phone': phone};
}
