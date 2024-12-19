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

  MesoregionModel toModel() =>
      MesoregionModel(id: id, name: name, sa: sa?.toModel());
}
