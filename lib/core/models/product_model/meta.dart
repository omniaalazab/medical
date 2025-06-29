import 'link.dart';

class Meta {
  List<int>? total;
  int? count;
  List<int>? perPage;
  List<int>? currentPage;
  List<int>? lastPage;
  int? from;
  List<Link>? links;
  String? path;
  int? to;

  Meta({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.links,
    this.path,
    this.to,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json['total'] as List<int>?,
    count: json['count'] as int?,
    perPage: json['per_page'] as List<int>?,
    currentPage: json['current_page'] as List<int>?,
    lastPage: json['last_page'] as List<int>?,
    from: json['from'] as int?,
    links: (json['links'] as List<dynamic>?)
        ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
        .toList(),
    path: json['path'] as String?,
    to: json['to'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'count': count,
    'per_page': perPage,
    'current_page': currentPage,
    'last_page': lastPage,
    'from': from,
    'links': links?.map((e) => e.toJson()).toList(),
    'path': path,
    'to': to,
  };
}
