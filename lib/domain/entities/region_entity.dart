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

  RegionModel toModel() => RegionModel(id: id, acronym: acronym, name: name);
}
