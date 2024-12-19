import '../../data/models/mesoregion_model.dart';
import 'sa_entity.dart';

class MesoregionEntity {
  MesoregionEntity({
    required this.id,
    required this.name,
    required this.sa,
  });

  final int id;
  final String name;
  final SaEntity? sa;

  factory MesoregionEntity.fromModel(MesoregionModel model) {
    return MesoregionEntity(
      id: model.id,
      name: model.name,
      sa: model.sa != null ? SaEntity.fromModel(model.sa!) : null,
    );
  }
}
