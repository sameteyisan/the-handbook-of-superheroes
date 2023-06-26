import 'dart:convert';

class PowerstatModel {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;
  PowerstatModel({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'intelligence': intelligence});
    result.addAll({'strength': strength});
    result.addAll({'speed': speed});
    result.addAll({'durability': durability});
    result.addAll({'power': power});
    result.addAll({'combat': combat});

    return result;
  }

  factory PowerstatModel.fromMap(Map<String, dynamic> map) {
    return PowerstatModel(
      intelligence: map['intelligence'] ?? '',
      strength: map['strength'] ?? '',
      speed: map['speed'] ?? '',
      durability: map['durability'] ?? '',
      power: map['power'] ?? '',
      combat: map['combat'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PowerstatModel.fromJson(String source) => PowerstatModel.fromMap(json.decode(source));
}
