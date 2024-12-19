import '../../domain/domain.dart';

class RegionModel {
  RegionModel({
    required this.id,
    required this.acronym,
    required this.name,
  });

  final int id;
  final String acronym;
  final String name;

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json["id"] ?? 0,
      acronym: json["sigla"] ?? "",
      name: json["nome"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sigla": acronym,
        "nome": name,
      };

  @override
  String toString() {
    return "$id, $acronym, $name, ";
  }

  RegionEntity toEntity() {
    return RegionEntity(
      id: id,
      acronym: acronym,
      name: name,
    );
  }
}
