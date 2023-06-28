import 'dart:convert';

class BasicHeroModel {
  final String id;
  final String name;
  final String url;
  final DateTime? date;
  BasicHeroModel({
    required this.id,
    required this.name,
    required this.url,
    this.date,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'url': url});
    if (date != null) {
      result.addAll({'date': date!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory BasicHeroModel.fromMap(Map<String, dynamic> map) {
    return BasicHeroModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
      date: map['date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['date']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicHeroModel.fromJson(String source) => BasicHeroModel.fromMap(json.decode(source));

  BasicHeroModel copyWith({
    String? id,
    String? name,
    String? url,
    DateTime? date,
  }) {
    return BasicHeroModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      date: date ?? this.date,
    );
  }
}
