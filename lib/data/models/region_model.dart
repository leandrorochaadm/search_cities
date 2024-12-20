import 'package:equatable/equatable.dart';

import '../../domain/entities/region_entity.dart';

class RegionModel extends Equatable {
  const RegionModel({
    required this.id,
    required this.acronym,
    required this.name,
  });

  final int id;
  final String acronym;
  final String name;

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json["id"] ?? 0,
      acronym: json["sigla"] ?? "",
      name: json["nome"] ?? "",
    );
  }

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

  toEntity() => RegionEntity(id: id, acronym: acronym, name: name);
}
