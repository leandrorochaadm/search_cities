import 'entities.dart';

class CityEntity {
  CityEntity({
    required this.id,
    required this.name,
    required this.microregion,
  });

  final int id;
  final String name;
  final MicroregionEntity? microregion;
}
