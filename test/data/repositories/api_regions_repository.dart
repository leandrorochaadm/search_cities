import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/data/models/models.dart';
import 'package:searchcities/data/repositories/repositories.dart';
import 'package:searchcities/data/sources/regions_data_source.dart';
import 'package:searchcities/domain/domain.dart';

class MockRegionsDataSource extends Mock implements RegionsDataSource {}

void main() {
  late ApiRegionsRepository repository;
  late MockRegionsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockRegionsDataSource();
    repository = ApiRegionsRepository(mockDataSource);
  });

  group('ApiRegionsRepository.getRegions', () {
    final mockRegionModels = [
      RegionModel(id: 1, acronym: "UF1", name: "Region 1"),
      RegionModel(id: 2, acronym: "UF2", name: "Region 2"),
    ];

    final expectedRegionEntities = mockRegionModels
        .map((model) => RegionEntity(
              id: model.id,
              acronym: model.acronym,
              name: model.name,
            ))
        .toList();

    test(
        'should return a list of RegionEntity when data source call is successful',
        () async {
      // Arrange
      when(() => mockDataSource.getRegions())
          .thenAnswer((_) async => mockRegionModels);

      // Act
      final result = await repository.getRegions();

      // Assert
      expect(result, expectedRegionEntities);
      verify(() => mockDataSource.getRegions()).called(1);
    });

    test('should throw exception when data source call fails', () async {
      // Arrange
      final exception = Exception('Data source error');
      when(() => mockDataSource.getRegions()).thenThrow(exception);

      // Act
      final call = repository.getRegions;

      // Assert
      expect(() => call(), throwsA(exception));
      verify(() => mockDataSource.getRegions()).called(1);
    });
  });
}
