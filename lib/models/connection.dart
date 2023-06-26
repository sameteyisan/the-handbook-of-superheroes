import 'dart:convert';

class ConnectionModel {
  final String groupAffiliation;
  final String relatives;
  ConnectionModel({
    required this.groupAffiliation,
    required this.relatives,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'group-affiliation': groupAffiliation});
    result.addAll({'relatives': relatives});

    return result;
  }

  factory ConnectionModel.fromMap(Map<String, dynamic> map) {
    return ConnectionModel(
      groupAffiliation: map['group-affiliation'] ?? '',
      relatives: map['relatives'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ConnectionModel.fromJson(String source) => ConnectionModel.fromMap(json.decode(source));
}
