import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  const CityEntity({
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
}
