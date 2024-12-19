import '../../data/models/sa_model.dart';
import 'entities.dart';

class SaEntity {
  SaEntity({
    required this.id,
    required this.acronym,
    required this.name,
    required this.region,
  });

  final int id;
  final String acronym;
  final String name;
  final RegionEntity? region;

  @override
  String toString() {
    return "$id, $acronym, $name, $region, ";
  }

  SaModel toModel() => SaModel(
        id: id,
        acronym: acronym,
        name: name,
        region: region?.toModel(),
      );
}
