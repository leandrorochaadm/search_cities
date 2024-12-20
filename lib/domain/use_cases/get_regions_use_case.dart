import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/regions_repository.dart';

class GetRegionsUseCase {
  final RegionsRepository regionsRepository;

  GetRegionsUseCase(this.regionsRepository);

  Future<Either<Failure, List<RegionEntity>>> call() async {
    try {
      final regions = await regionsRepository.getRegions();

      return Right(regions); // Retorno bem-sucedido
    } on Exception catch (e) {
      // Converte a exceção em uma Failure usando Failure.fromException
      final failure = Failure.fromException(e);
      return Left(failure); // Retorno com erro
    }
  }
}
