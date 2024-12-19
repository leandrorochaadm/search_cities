import '../../domain/entities/entities.dart';
import 'models.dart';

class SaModel {
  SaModel({
    required this.id,
    required this.acronym,
    required this.name,
    required this.region,
  });

  final int id;
  final String acronym;
  final String name;
  final RegionModel? region;

  factory SaModel.fromJson(Map<String, dynamic> json) {
    return SaModel(
      id: json["id"] ?? 0,
      acronym: json["sigla"] ?? "",
      name: json["nome"] ?? "",
      region:
          json["regiao"] == null ? null : RegionModel.fromJson(json["regiao"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "sigla": acronym,
        "nome": name,
        "regiao": region?.toJson(),
      };

  @override
  String toString() {
    return "$id, $acronym, $name, $region, ";
  }

  SaEntity toEntity() => SaEntity(
        id: id,
        acronym: acronym,
        name: name,
        region: region?.toEntity(),
      );
}
