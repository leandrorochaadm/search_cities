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

  RegionsLoaded(this.regions);

  @override
  List<Object?> get props => [regions];
}

class CitiesLoaded extends RegionCityState {
  final List<CityEntity> cities;

  CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class RegionCityError extends RegionCityState {
  final String message;

  RegionCityError(this.message);

  @override
  List<Object?> get props => [message];
}
