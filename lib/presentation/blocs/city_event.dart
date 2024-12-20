import 'package:equatable/equatable.dart';

abstract class RegionCityEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRegionsEvent extends RegionCityEvent {}

class FetchCitiesByRegionEvent extends RegionCityEvent {
  final int regionId;

  FetchCitiesByRegionEvent(this.regionId);

  @override
  List<Object?> get props => [regionId];
}
