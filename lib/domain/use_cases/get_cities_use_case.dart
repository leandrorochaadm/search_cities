import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../entities/city_entity.dart';
import '../repositories/cities_repository.dart';

class GetCitiesUseCase {
  final CitiesRepository _citiesRepository;

  GetCitiesUseCase(this._citiesRepository);

  Future<Either<Failure, List<CityEntity>>> call() async {
    try {
      final cities = await _citiesRepository.getCities();
      return Right(cities); // Retorno bem-sucedido
    } catch (e) {
      // Converte a exceção em uma Failure usando Failure.fromException
      final failure = Failure.fromException(e as Exception);
      return Left(failure); // Retorno com erro
    }
  }
}
