class Links {
  List<String>? first;
  List<String>? last;
  List<dynamic>? prev;
  List<dynamic>? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json['first'] as List<String>?,
    last: json['last'] as List<String>?,
    prev: json['prev'] as List<dynamic>?,
    next: json['next'] as List<dynamic>?,
  );

  Map<String, dynamic> toJson() => {
    'first': first,
    'last': last,
    'prev': prev,
    'next': next,
  };
}
