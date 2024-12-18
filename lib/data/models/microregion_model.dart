import 'models.dart';

class MicroregionModel {
  MicroregionModel({
    required this.id,
    required this.name,
    required this.mesoregion,
  });

  final int id;
  final String name;
  final MesoregionModel? mesoregion;

  factory MicroregionModel.fromJson(Map<String, dynamic> json) {
    return MicroregionModel(
      id: json["id"] ?? 0,
      name: json["nome"] ?? "",
      mesoregion: json["mesorregiao"] == null
          ? null
          : MesoregionModel.fromJson(json["mesorregiao"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": name,
        "mesorregiao": mesoregion?.toJson(),
      };

  @override
  String toString() {
    return "$id, $name, $mesoregion, ";
  }
}
