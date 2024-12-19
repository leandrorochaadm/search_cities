import '../../domain/entities/city_entity.dart';

class CityDetailsModel {
  final String cityName;
  final String stateName;
  final String stateAcronym;
  final int cityId;
  final String microregionName;
  final String mesoregionName;

  CityDetailsModel({
    required this.cityName,
    required this.stateName,
    required this.stateAcronym,
    required this.cityId,
    required this.microregionName,
    required this.mesoregionName,
  });
}

extension CityDetailsExtension on CityEntity {
  CityDetailsModel toCityDetails() {
    final state = microregion?.mesoregion?.sa;
    final microregionName = microregion?.name ?? "Microrregião desconhecido";
    final mesoregionName =
        microregion?.mesoregion?.name ?? "Mesorregião desconhecido";

    return CityDetailsModel(
      cityName: name,
      stateName: state?.name ?? "Estado desconhecido",
      stateAcronym: state?.acronym ?? "S/D",
      cityId: id,
      microregionName: microregionName,
      mesoregionName: mesoregionName,
    );
  }
}
