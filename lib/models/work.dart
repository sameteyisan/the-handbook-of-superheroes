import 'dart:convert';

class WorkModel {
  final String occupation;
  final String base;
  WorkModel({
    required this.occupation,
    required this.base,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'occupation': occupation});
    result.addAll({'base': base});

    return result;
  }

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      occupation: map['occupation'] ?? '',
      base: map['base'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkModel.fromJson(String source) => WorkModel.fromMap(json.decode(source));
}
