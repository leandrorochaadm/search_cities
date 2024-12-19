import '../../data/models/city_model.dart';
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

  CityModel toModel() =>
      CityModel(id: id, name: name, microregion: microregion?.toModel());
}
