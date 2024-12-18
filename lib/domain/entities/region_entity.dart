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
}
