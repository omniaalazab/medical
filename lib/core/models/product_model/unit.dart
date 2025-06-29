class Unit {
  int? id;
  String? name;
  dynamic abbreviation;

  Unit({this.id, this.name, this.abbreviation});

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json['id'] as int?,
    name: json['name'] as String?,
    abbreviation: json['abbreviation'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'abbreviation': abbreviation,
  };
}
