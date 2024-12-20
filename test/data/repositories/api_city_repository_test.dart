import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/data/models/models.dart';
import 'package:searchcities/data/repositories/repositories.dart';
import 'package:searchcities/data/sources/cities_data_source.dart';
import 'package:searchcities/domain/entities/entities.dart';

class MockCitiesDataSource extends Mock implements CitiesDataSource {}

void main() {
  late ApiCitiesRepository repository;
  late MockCitiesDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCitiesDataSource();
    repository = ApiCitiesRepository(mockDataSource);
  });

  group('ApiCitiesRepository.getCities', () {
    const regionId = 1;

    final mockCityModels = [
      CityModel(
        cityId: 1,
        cityName: "City 1",
        microregion: "Microregion 1",
        mesoregion: "Mesoregion 1",
        saAcronym: "UF1",
        saName: "State 1",
      ),
      CityModel(
        cityId: 2,
        cityName: "City 2",
        microregion: "Microregion 2",
        mesoregion: "Mesoregion 2",
        saAcronym: "UF2",
        saName: "State 2",
      ),
    ];

    final expectedCityEntities = mockCityModels
        .map((model) => CityEntity(
              cityId: model.cityId,
              cityName: model.cityName,
              microregion: model.microregion,
              mesoregion: model.mesoregion,
              saAcronym: model.saAcronym,
              saName: model.saName,
            ))
        .toList();

    test(
        'should return a list of CityEntity when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.getCities(regionId))
          .thenAnswer((_) async => mockCityModels);

      // Act
      final result = await repository.getCities(regionId);

      // Assert
      expect(result, expectedCityEntities);
      verify(() => mockDataSource.getCities(regionId)).called(1);
    });

    test('should throw exception when data source call fails', () async {
      // Arrange
      final exception = Exception('Data source error');
      when(() => mockDataSource.getCities(regionId)).thenThrow(exception);

      // Act
      final call = repository.getCities;

      // Assert
      expect(() => call(regionId), throwsA(exception));
      verify(() => mockDataSource.getCities(regionId)).called(1);
    });
  });
}
