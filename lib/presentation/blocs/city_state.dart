import 'package:equatable/equatable.dart';

import '../../domain/domain.dart';

abstract class CityState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CityLoading extends CityState {}

class CityLoaded extends CityState {
  final List<CityEntity> cities;

  CityLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class CityError extends CityState {
  final String message;

  CityError(this.message);

  @override
  List<Object?> get props => [message];
}
