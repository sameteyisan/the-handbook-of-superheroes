import 'dart:convert';

import 'package:the_handbook_of_superheroes/models/appearance.dart';
import 'package:the_handbook_of_superheroes/models/biography.dart';
import 'package:the_handbook_of_superheroes/models/connection.dart';
import 'package:the_handbook_of_superheroes/models/image.dart';
import 'package:the_handbook_of_superheroes/models/powerstat.dart';
import 'package:the_handbook_of_superheroes/models/work.dart';

class SuperheroModel {
  final String id;
  final String name;
  final PowerstatModel powerstats;
  final BiograpyModel biography;
  final AppearanceModel appearance;
  final WorkModel work;
  final ConnectionModel connections;
  final ImageModel image;
  SuperheroModel({
    required this.id,
    required this.name,
    required this.powerstats,
    required this.biography,
    required this.appearance,
    required this.work,
    required this.connections,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'powerstats': powerstats.toMap()});
    result.addAll({'biography': biography.toMap()});
    result.addAll({'appearance': appearance.toMap()});
    result.addAll({'work': work.toMap()});
    result.addAll({'connections': connections.toMap()});
    result.addAll({'image': image.toMap()});

    return result;
  }

  factory SuperheroModel.fromMap(Map<String, dynamic> map) {
    return SuperheroModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      powerstats: PowerstatModel.fromMap(map['powerstats']),
      biography: BiograpyModel.fromMap(map['biography']),
      appearance: AppearanceModel.fromMap(map['appearance']),
      work: WorkModel.fromMap(map['work']),
      connections: ConnectionModel.fromMap(map['connections']),
      image: ImageModel.fromMap(map['image']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SuperheroModel.fromJson(String source) => SuperheroModel.fromMap(json.decode(source));
}
