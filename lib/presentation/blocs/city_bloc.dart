import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../presentation.dart'; // Necessário para o groupBy

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
      (failure) => emit(CityError(_mapFailureToMessage(failure))),
      (cities) {
        // Agrupar cidades por estado
        final groupedCities = groupBy<CityEntity, String>(
          cities,
          (city) =>
              city.microregion?.mesoregion?.sa?.name ?? "Estado Desconhecido",
        );

        // Emitir o estado com as cidades agrupadas
        emit(GroupedCitiesLoaded(groupedCities));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return "Erro no servidor. Tente novamente mais tarde.";
      case const (NetworkFailure):
        return "Verifique sua conexão com a internet e tente novamente.";
      case const (UnknownFailure):
      default:
        return "Um erro inesperado ocorreu.";
    }
  }
}
