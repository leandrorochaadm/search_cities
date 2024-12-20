import 'package:equatable/equatable.dart';

class RegionEntity extends Equatable {
  const RegionEntity({
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

  @override
  List<Object?> get props => [
        id,
        acronym,
        name,
      ];
}
