import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class CityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CityLoading extends CityState {}

class CityError extends CityState {
  final String message;

  CityError(this.message);

  @override
  List<Object?> get props => [message];
}

class CityLoaded extends CityState {
  final Map<String, List<CityEntity>> groupedCities;

  CityLoaded(this.groupedCities);

  @override
  List<Object?> get props => [groupedCities];
}
