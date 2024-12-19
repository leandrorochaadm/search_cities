import '../../data/models/region_model.dart';

class RegionEntity {
  RegionEntity({
    required this.id,
    required this.acronym,
    required this.name,
  });

  final int id;
  final String acronym;
  final String name;

  @override
  String toString() {
    return "$id, $acronym, $name, ";
  }

  factory RegionEntity.fromModel(RegionModel model) {
    return RegionEntity(
      id: model.id,
      acronym: model.acronym,
      name: model.name,
    );
  }
}
