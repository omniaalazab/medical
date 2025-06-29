class Brand {
  int? id;
  String? name;
  dynamic logoUrl;

  Brand({this.id, this.name, this.logoUrl});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json['id'] as int?,
    name: json['name'] as String?,
    logoUrl: json['logo_url'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'logo_url': logoUrl,
  };
}
