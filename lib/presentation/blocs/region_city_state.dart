import 'package:equatable/equatable.dart';

import '../../domain/entities/entities.dart';

abstract class RegionCityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegionCityInitial extends RegionCityState {}

class RegionCityLoading extends RegionCityState {}

class RegionsLoaded extends RegionCityState {
  final List<RegionEntity> regions;
  final List<CityEntity>? cities;

  RegionsLoaded({required this.regions, this.cities});

  @override
  List<Object?> get props => [regions, cities];
}

class CitiesLoaded extends RegionCityState {
  final List<RegionEntity> regions; // Preserva as regiões
  final List<CityEntity> cities; // Lista de cidades carregadas

  CitiesLoaded({required this.regions, required this.cities});

  @override
  List<Object?> get props => [regions, cities];
}

class RegionCityError extends RegionCityState {
  final String message;

  RegionCityError(this.message);

  @override
  List<Object?> get props => [message];
}
