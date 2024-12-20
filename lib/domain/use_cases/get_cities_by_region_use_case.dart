import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

class GetCitiesByRegionUseCase {
  final CitiesRepository citiesRepository;

  GetCitiesByRegionUseCase({required this.citiesRepository});

  Future<Either<Failure, List<CityEntity>>> call({
    required int regionId,
  }) async {
    try {
      final cities = await citiesRepository.getCities(regionId);

      return Right(cities);
    } on NetworkException catch (_) {
      return Left(Failure.network('Não foi possivel carregar as cidades'));
    } on Exception catch (e) {
      // Converte a exceção em uma Failure usando Failure.fromException
      final failure = Failure.fromException(e);
      return Left(failure);
    } catch (_) {
      return Left(Failure.unknown());
    }
  }
}
