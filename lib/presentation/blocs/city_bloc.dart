import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCitiesUseCase getCitiesUseCase;

  CityBloc(this.getCitiesUseCase) : super(CityLoading()) {
    on<FetchCitiesEvent>(_onFetchCities);
  }

  Future<void> _onFetchCities(
    FetchCitiesEvent event,
    Emitter<CityState> emit,
  ) async {
    emit(CityLoading());

    final result = await getCitiesUseCase();

    result.fold(
      (failure) => emit(CityError(failure.message)),
      (cities) {
        // Agrupar cidades por estado
        final groupedCities = groupBy<CityEntity, String>(
          cities,
          (city) {
            return '${city.microregion?.mesoregion?.sa?.name ?? ""} (${city.microregion?.mesoregion?.sa?.acronym ?? ""})';
          },
        );

        // Ordenar as chaves do mapa
        final sortedGroupedCities = Map.fromEntries(
          groupedCities.entries.toList()
            ..sort((a, b) => a.key.compareTo(b.key)),
        );

        // Emitir o estado com as cidades agrupadas
        emit(CityLoaded(sortedGroupedCities));
      },
    );
  }
}
