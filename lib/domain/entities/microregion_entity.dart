import '../../data/models/microregion_model.dart';
import 'entities.dart';

class MicroregionEntity {
  MicroregionEntity({
    required this.id,
    required this.nome,
    required this.mesoregion,
  });

  final int id;
  final String nome;
  final MesoregionEntity? mesoregion;

  factory MicroregionEntity.fromModel(MicroregionModel model) {
    return MicroregionEntity(
      id: model.id,
      nome: model.name,
      mesoregion: model.mesoregion != null
          ? MesoregionEntity.fromModel(model.mesoregion!)
          : null,
    );
  }
}
