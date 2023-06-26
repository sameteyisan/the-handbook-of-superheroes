import 'dart:convert';

class AppearanceModel {
  final String gender;
  final String race;
  final String height;
  final String weight;
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
      height: map['height'] ?? '', // List<String>.from(map['height']).join(" - "),
      weight: map['weight'] ?? '', // List<String>.from(map['weight']).join(" - "),
      eyeColor: map['eye-color'] ?? '',
      hairColor: map['hair-color'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppearanceModel.fromJson(String source) => AppearanceModel.fromMap(json.decode(source));
}
