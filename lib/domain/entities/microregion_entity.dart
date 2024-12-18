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
}
