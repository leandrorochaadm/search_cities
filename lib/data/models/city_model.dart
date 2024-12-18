import 'models.dart';

class CityModel {
  CityModel({
    required this.id,
    required this.nome,
    required this.microregion,
  });

  final int id;
  final String nome;
  final MicroregionModel? microregion;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json["id"] ?? 0,
      nome: json["nome"] ?? "",
      microregion: json["microrregiao"] == null
          ? null
          : MicroregionModel.fromJson(json["microrregiao"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "microrregiao": microregion?.toJson(),
      };

  @override
  String toString() {
    return "$id, $nome, $microregion,  ";
  }
}
