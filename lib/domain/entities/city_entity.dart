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

  factory CityEntity.fromModel(CityModel model) {
    return CityEntity(
      id: model.id,
      name: model.name,
      microregion: model.microregion == null
          ? null
          : MicroregionEntity.fromModel(model.microregion!),
    );
  }
}
