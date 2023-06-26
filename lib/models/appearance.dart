import 'dart:convert';

class AppearanceModel {
  final String gender;
  final String race;
  final List<String> height;
  final List<String> weight;
  final String eyeColor;
  final String hairColor;
  AppearanceModel({
    required this.gender,
    required this.race,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hairColor,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'gender': gender});
    result.addAll({'race': race});
    result.addAll({'height': height});
    result.addAll({'weight': weight});
    result.addAll({'eye-color': eyeColor});
    result.addAll({'hair-color': hairColor});

    return result;
  }

  factory AppearanceModel.fromMap(Map<String, dynamic> map) {
    return AppearanceModel(
      gender: map['gender'] ?? '',
      race: map['race'] ?? '',
      height: List<String>.from(map['height']),
      weight: List<String>.from(map['weight']),
      eyeColor: map['eye-color'] ?? '',
      hairColor: map['hair-color'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppearanceModel.fromJson(String source) => AppearanceModel.fromMap(json.decode(source));
}
