import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import 'blocs.dart';

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
        emit(CityLoaded(cities));
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return "Erro no servidor. Por favor, tente novamente mais tarde.";
      case const (NetworkFailure):
        return "Verifique sua conexão com a internet e tente novamente.";
      case const (UnknownFailure):
        return "Ocorreu um erro inesperado.";
      default:
        return "Ocorreu um erro desconhecido. Por favor, entre em contato com o suporte.";
    }
  }
}
