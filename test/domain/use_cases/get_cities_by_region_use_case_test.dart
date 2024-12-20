import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/core/core.dart';
import 'package:searchcities/domain/domain.dart';

class MockCitiesRepository extends Mock implements CitiesRepository {}

void main() {
  late GetCitiesByRegionUseCase useCase;
  late MockCitiesRepository mockCitiesRepository;

  setUp(() {
    mockCitiesRepository = MockCitiesRepository();
    useCase = GetCitiesByRegionUseCase(citiesRepository: mockCitiesRepository);
  });

  setUpAll(() {
    // Registrar fallback para evitar problemas com valores de teste
    registerFallbackValue(<CityEntity>[]);
  });

  group('GetCitiesByRegionUseCase', () {
    const regionId = 1;

    test('should return a list of CityEntity on successful fetch', () async {
      // Arrange
      final mockCities = [
        CityEntity(
            cityName: 'City 1',
            saName: 'State 1',
            saAcronym: 'S1',
            cityId: 1,
            microregion: '',
            mesoregion: ''),
        CityEntity(
            cityName: 'City 2',
            saName: 'State 2',
            saAcronym: 'S2',
            cityId: 2,
            microregion: '',
            mesoregion: ''),
      ];
      when(() => mockCitiesRepository.getCities(regionId))
          .thenAnswer((_) async => mockCities);

      // Act
      final result = await useCase.call(regionId: regionId);

      // Assert
      result.fold(
        (_) => fail('Expected a Right, but got a Failure.'),
        (cities) {
          expect(cities, isA<List<CityEntity>>());
          expect(cities.length, mockCities.length);
        },
      );

      verify(() => mockCitiesRepository.getCities(regionId)).called(1);
    });

    test('should return network failure when NetworkException is thrown',
        () async {
      // Arrange
      when(() => mockCitiesRepository.getCities(regionId))
          .thenThrow(NetworkException('Network error'));

      // Act
      final result = await useCase.call(regionId: regionId);

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
          expect(failure.message, 'Não foi possivel carregar as cidades');
        },
        (_) => fail('Expected a Failure but got a success result.'),
      );

      verify(() => mockCitiesRepository.getCities(regionId)).called(1);
    });

    test('should return server error when ServerErrorException is thrown',
        () async {
      // Arrange
      when(() => mockCitiesRepository.getCities(regionId))
          .thenThrow(ServerErrorException('Server error'));

      // Act
      final result = await useCase.call(regionId: regionId);

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
          expect(
              failure.message, 'Erro no servidor. Tente novamente mais tarde.');
        },
        (_) => fail('Expected a Failure but got a success result.'),
      );

      verify(() => mockCitiesRepository.getCities(regionId)).called(1);
    });

    test('should return unknown error when UnknownErrorException is thrown',
        () async {
      // Arrange
      when(() => mockCitiesRepository.getCities(regionId))
          .thenThrow(UnknownErrorException('Unknown error'));

      // Act
      final result = await useCase.call(regionId: regionId);

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
          expect(failure.message, 'Um erro inesperado ocorreu.');
        },
        (_) => fail('Expected a Failure but got a success result.'),
      );

      verify(() => mockCitiesRepository.getCities(regionId)).called(1);
    });

    test('should return unknown failure for unexpected errors', () async {
      // Arrange
      when(() => mockCitiesRepository.getCities(regionId)).thenThrow(Object());

      // Act
      final result = await useCase.call(regionId: regionId);

      // Assert
      result.fold(
        (failure) {
          expect(failure, isA<Failure>());
          expect(failure.message, 'Um erro inesperado ocorreu.');
        },
        (_) => fail('Expected a Failure but got a success result.'),
      );

      verify(() => mockCitiesRepository.getCities(regionId)).called(1);
    });
  });
}
