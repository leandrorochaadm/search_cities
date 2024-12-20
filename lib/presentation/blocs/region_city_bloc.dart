import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class RegionCityBloc extends Bloc<RegionCityEvent, RegionCityState> {
  final GetRegionsUseCase getRegionsUseCase;
  final GetCitiesByRegionUseCase getCitiesByRegionUseCase;

  RegionCityBloc({
    required this.getRegionsUseCase,
    required this.getCitiesByRegionUseCase,
  }) : super(RegionCityInitial()) {
    on<FetchRegionsEvent>(_onFetchRegions);
    on<FetchCitiesByRegionEvent>(_onFetchCitiesByRegion);
    on<ClearCitiesEvent>(_onClearCities);
  }

  Future<void> _onFetchRegions(
      FetchRegionsEvent event, Emitter<RegionCityState> emit) async {
    emit(RegionCityLoading());

    final result = await getRegionsUseCase();

    result.fold(
      (failure) => emit(RegionCityError(failure.message)),
      (regions) => emit(RegionsLoaded(regions: regions, cities: null)),
    );
  }

  Future<void> _onClearCities(
      ClearCitiesEvent event, Emitter<RegionCityState> emit) async {
    emit(RegionCityLoading());

    final result = await getRegionsUseCase();

    result.fold(
      (failure) => emit(RegionCityError(failure.message)),
      (regions) => emit(RegionsLoaded(regions: regions, cities: null)),
    );
  }

  Future<void> _onFetchCitiesByRegion(
      FetchCitiesByRegionEvent event, Emitter<RegionCityState> emit) async {
    final regions = (state is RegionsLoaded)
        ? (state as RegionsLoaded).regions
        : <RegionEntity>[];

    emit(RegionCityLoading());

    final result =
        await getCitiesByRegionUseCase.call(regionId: event.regionId);

    result.fold(
      (failure) => emit(RegionCityError(failure.message)),
      (cities) => emit(RegionsLoaded(
          regions: regions, cities: cities, selectedRegionId: event.regionId)),
    );
  }
}
