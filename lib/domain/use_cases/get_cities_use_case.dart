import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../entities/city_entity.dart';
import '../repositories/cities_repository.dart';

class GetCitiesUseCase {
  final CitiesRepository _citiesRepository;

  GetCitiesUseCase(this._citiesRepository);

  Future<Either<Failure, List<CityEntity>>> call() async {
    try {
      final cities = await _citiesRepository.getCities();
      cities.sort((a, b) => a.name.compareTo(b.name));

      return Right(cities); // Retorno bem-sucedido
    } on Exception catch (e) {
      // Converte a exceção em uma Failure usando Failure.fromException
      final failure = Failure.fromException(e);
      return Left(failure); // Retorno com erro
    }
  }
}
