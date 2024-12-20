import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/core/core.dart';
import 'package:searchcities/data/models/models.dart';
import 'package:searchcities/data/sources/regions_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late RegionsDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = RegionsDataSource(mockDio);
  });

  group('RegionsDataSource.getRegions', () {
    const url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome';

    final mockResponseData = [
      {"id": 1, "sigla": "UF1", "nome": "Region 1"},
      {"id": 2, "sigla": "UF2", "nome": "Region 2"},
    ];

    test('should return a list of RegionModel when the API call is successful',
        () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 200,
            data: mockResponseData,
          ));

      // Act
      final result = await dataSource.getRegions();

      // Assert
      expect(result, isA<List<RegionModel>>());
      expect(result.length, mockResponseData.length);
      expect(result.first.name, 'Region 1');
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw NetworkException when API returns a non-200 status code',
        () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 500,
            data: null,
          ));

      // Act
      final call = dataSource.getRegions;

      // Assert
      expect(() => call(), throwsA(isA<NetworkException>()));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should handle DioException and throw a custom exception', () async {
      // Arrange
      when(() => mockDio.get(url)).thenThrow(DioException(
        requestOptions: RequestOptions(path: url),
        error: 'Dio error',
      ));

      // Act
      final call = dataSource.getRegions;

      // Assert
      expect(() => call(), throwsA(isA<AppException>()));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw UnknownErrorException for unexpected errors', () async {
      // Arrange
      when(() => mockDio.get(url)).thenThrow(Exception('Unexpected error'));

      // Act
      final call = dataSource.getRegions;

      // Assert
      expect(() => call(), throwsA(isA<UnknownErrorException>()));
      verify(() => mockDio.get(url)).called(1);
    });
  });
}
