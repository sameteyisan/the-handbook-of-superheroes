import 'dart:convert';

class BiograpyModel {
  final String fullname;
  final String alterEgos;
  final List<String> aliases;
  final String placeOfBirth;
  final String firstAppearance;
  final String publisher;
  final String alignment;
  BiograpyModel({
    required this.fullname,
    required this.alterEgos,
    required this.aliases,
    required this.placeOfBirth,
    required this.firstAppearance,
    required this.publisher,
    required this.alignment,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'full-name': fullname});
    result.addAll({'alter-egos': alterEgos});
    result.addAll({'aliases': aliases});
    result.addAll({'place-of-birth': placeOfBirth});
    result.addAll({'first-appearance': firstAppearance});
    result.addAll({'publisher': publisher});
    result.addAll({'alignment': alignment});

    return result;
  }

  factory BiograpyModel.fromMap(Map<String, dynamic> map) {
    return BiograpyModel(
      fullname: map['full-name'] ?? '',
      alterEgos: map['alter-egos'] ?? '',
      aliases: List<String>.from(map['aliases']),
      placeOfBirth: map['place-of-birth'] ?? '',
      firstAppearance: map['first-appearance'] ?? '',
      publisher: map['publisher'] ?? '',
      alignment: map['alignment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BiograpyModel.fromJson(String source) => BiograpyModel.fromMap(json.decode(source));
}
