import 'models.dart';

class CityModel {
  CityModel({
    required this.id,
    required this.name,
    required this.microregion,
  });

  final int id;
  final String name;
  final MicroregionModel? microregion;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] ?? 0,
      name: json["nome"] ?? "",
      microregion: json["microrregiao"] == null
          ? null
          : MicroregionModel.fromJson(json["microrregiao"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": name,
        "microrregiao": microregion?.toJson(),
      };

  @override
  String toString() {
    return "$id, $name, $microregion,  ";
  }
}
