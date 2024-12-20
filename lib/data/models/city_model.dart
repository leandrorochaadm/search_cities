import 'package:equatable/equatable.dart';

import '../../domain/entities/city_entity.dart';

class CityModel extends Equatable {
  const CityModel({
    required this.cityId,
    required this.cityName,
    required this.microregion,
    required this.mesoregion,
    required this.saAcronym,
    required this.saName,
  });

  final int cityId;
  final String cityName;
  final String microregion;
  final String mesoregion;
  final String saAcronym;
  final String saName;

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      cityId: json["municipio-id"] ?? 0,
      cityName: json["municipio-nome"] ?? "",
      microregion: json["microrregiao-nome"] ?? "",
      mesoregion: json["mesorregiao-nome"] ?? "",
      saAcronym: json["UF-sigla"] ?? "",
      saName: json["UF-nome"] ?? "",
    );
  }

  @override
  String toString() {
    return "$cityId, $cityName, $microregion, $mesoregion, $saAcronym, $saName, ";
  }

  @override
  List<Object?> get props => [
        cityId,
        cityName,
        microregion,
        mesoregion,
        saAcronym,
        saName,
      ];

  toEntity() => CityEntity(
        cityId: cityId,
        cityName: cityName,
        microregion: microregion,
        mesoregion: mesoregion,
        saAcronym: saAcronym,
        saName: saName,
      );
}
