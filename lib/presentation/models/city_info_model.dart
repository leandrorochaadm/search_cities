import '../../domain/entities/entities.dart';

class CityInfoModel {
  final String cityName;
  final String stateName;
  final String stateAcronym;

  CityInfoModel({
    required this.cityName,
    required this.stateName,
    required this.stateAcronym,
  });

  @override
  String toString() =>
      "City: $cityName, State: $stateName, Acronym: $stateAcronym";
}

extension CityEntityExtension on CityEntity {
  CityInfoModel toCityInfo() {
    // Obter o nome do estado e sigla do estado através da cadeia de entidades
    final mesoregion = microregion?.mesoregion;
    final sa = mesoregion?.sa;

    return CityInfoModel(
      cityName: name,
      stateName: sa?.name ?? "Estado Desconhecido",
      stateAcronym: sa?.acronym ?? "S/D",
    );
  }
}
