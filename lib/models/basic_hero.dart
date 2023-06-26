import 'dart:convert';

class BasicHeroModel {
  final String id;
  final String name;
  final String url;
  BasicHeroModel({
    required this.id,
    required this.name,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'url': url});

    return result;
  }

  factory BasicHeroModel.fromMap(Map<String, dynamic> map) {
    return BasicHeroModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BasicHeroModel.fromJson(String source) => BasicHeroModel.fromMap(json.decode(source));
}
