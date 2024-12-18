import 'models.dart';

class MesoregionModel {
  MesoregionModel({
    required this.id,
    required this.name,
    required this.sa,
  });

  final int id;
  final String name;
  final SaModel? sa;

  factory MesoregionModel.fromJson(Map<String, dynamic> json) {
    return MesoregionModel(
      id: json["id"] ?? 0,
      name: json["nome"] ?? "",
      sa: json["UF"] == null ? null : SaModel.fromJson(json["UF"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": name,
        "UF": sa?.toJson(),
      };

  @override
  String toString() {
    return "$id, $name, $sa, ";
  }
}
