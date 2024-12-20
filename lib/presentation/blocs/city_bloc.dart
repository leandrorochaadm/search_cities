import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import 'blocs.dart';

class RegionCityBloc extends Bloc<RegionCityEvent, RegionCityState> {
  final GetRegionsUseCase getRegionsUseCase;
  final GetCitiesByRegionUseCase getCitiesByRegionUseCase;

  RegionCityBloc({
    required this.getRegionsUseCase,
    required this.getCitiesByRegionUseCase,
  }) : super(RegionCityInitial()) {
    on<FetchRegionsEvent>(_onFetchRegions);
    on<FetchCitiesByRegionEvent>(_onFetchCitiesByRegion);
  }

  Future<void> _onFetchRegions(
      FetchRegionsEvent event, Emitter<RegionCityState> emit) async {
    emit(RegionCityLoading());

    final result = await getRegionsUseCase();

    result.fold(
      (failure) => emit(RegionCityError(failure.message)),
      (regions) => emit(RegionsLoaded(regions)),
    );
  }

  Future<void> _onFetchCitiesByRegion(
      FetchCitiesByRegionEvent event, Emitter<RegionCityState> emit) async {
    emit(RegionCityLoading());

    final result = await getCitiesByRegionUseCase(regionId: event.regionId);

    result.fold(
      (failure) => emit(RegionCityError(failure.message)),
      (cities) => emit(CitiesLoaded(cities)),
    );
  }
}
