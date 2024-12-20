import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/core/core.dart';
import 'package:searchcities/domain/domain.dart';
import 'package:searchcities/domain/repositories/regions_repository.dart';

class MockRegionsRepository extends Mock implements RegionsRepository {}

void main() {
  late GetRegionsUseCase useCase;
  late MockRegionsRepository mockRegionsRepository;

  setUp(() {
    mockRegionsRepository = MockRegionsRepository();
    useCase = GetRegionsUseCase(mockRegionsRepository);
  });

  setUpAll(() {
    // Registrar tipos de parâmetros e retornos usados nos métodos do mock
    registerFallbackValue(<RegionEntity>[]);
  });

  group('GetRegionsUseCase', () {
    test('should return a list of RegionEntity on successful fetch', () async {
      // Arrange
      final mockRegions = [
        RegionEntity(id: 1, name: 'Region 1', acronym: 'R1'),
        RegionEntity(id: 2, name: 'Region 2', acronym: 'R2'),
      ];
      when(() => mockRegionsRepository.getRegions())
          .thenAnswer((_) async => mockRegions);

      // Act
      final result = await useCase.call();

      // Assert
      expect(result, Right(mockRegions));
      verify(() => mockRegionsRepository.getRegions()).called(1);
    });

    test('should return network failure when NetworkException is thrown',
        () async {
      // Arrange
      when(() => mockRegionsRepository.getRegions())
          .thenThrow(NetworkException('Network Exception'));

      // Act
      final result = await useCase.call();

      // Assert
      result.fold(
        (failure) {
          // Verifica se é um Failure.network com a mensagem correta
          expect(failure, isA<Failure>());
          expect(failure.message, 'Não foi possivel carregar os estados');
        },
        (_) => fail('Expected a Failure but got a success result'),
      );

      verify(() => mockRegionsRepository.getRegions()).called(1);
    });

    test('should return failure when an unknown exception is thrown', () async {
      // Arrange
      final mockException = Exception('Unexpected error');
      when(() => mockRegionsRepository.getRegions()).thenThrow(mockException);

      // Act
      final result = await useCase.call();

      // Assert
      result.fold(
        (failure) {
          // Verifica se é um Failure do tipo esperado
          expect(failure, isA<Failure>());
          expect(failure.message, 'Um erro inesperado ocorreu.');
        },
        (_) => fail('Expected a Failure but got a success result'),
      );

      verify(() => mockRegionsRepository.getRegions()).called(1);
    });

    test('should return unknown failure for unexpected errors', () async {
      // Arrange
      when(() => mockRegionsRepository.getRegions()).thenThrow(Object());

      // Act
      final result = await useCase.call();

      // Assert
      result.fold(
        (failure) {
          // Verifica se o Failure é do tipo esperado
          expect(failure, isA<Failure>());
          expect(failure.message, 'Um erro inesperado ocorreu.');
        },
        (_) => fail('Expected a Failure but got a success result'),
      );

      verify(() => mockRegionsRepository.getRegions()).called(1);
    });
  });
}
