import '../../data/models/microregion_model.dart';
import 'entities.dart';

class MicroregionEntity {
  MicroregionEntity({
    required this.id,
    required this.name,
    required this.mesoregion,
  });

  final int id;
  final String name;
  final MesoregionEntity? mesoregion;

  MicroregionModel toModel() => MicroregionModel(
        id: id,
        name: name,
        mesoregion: mesoregion?.toModel(),
      );
}
