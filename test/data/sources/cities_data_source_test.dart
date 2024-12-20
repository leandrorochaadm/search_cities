import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/core/core.dart';
import 'package:searchcities/data/models/models.dart';
import 'package:searchcities/data/sources/cities_data_source.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CitiesDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = CitiesDataSource(mockDio);
  });

  group('CitiesDataSource.getCities', () {
    const regionId = 1;
    final url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$regionId/municipios?orderBy=nome&view=nivelado';

    final mockResponseData = [
      {
        "municipio-id": 1,
        "municipio-nome": "City 1",
        "microrregiao-nome": "Microregion 1",
        "mesorregiao-nome": "Mesoregion 1",
        "UF-sigla": "UF1",
        "UF-nome": "State 1"
      },
      {
        "municipio-id": 2,
        "municipio-nome": "City 2",
        "microrregiao-nome": "Microregion 2",
        "mesorregiao-nome": "Mesoregion 2",
        "UF-sigla": "UF2",
        "UF-nome": "State 2"
      },
    ];

    test('should return a list of CityModel when the API call is successful',
        () async {
      // Arrange
      when(() => mockDio.get(url)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: url),
            statusCode: 200,
            data: mockResponseData,
          ));

      // Act
      final result = await dataSource.getCities(regionId);

      // Assert
      expect(result, isA<List<CityModel>>());
      expect(result.length, mockResponseData.length);
      expect(result.first.cityName, 'City 1');
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
      final call = dataSource.getCities;

      // Assert
      expect(() => call(regionId), throwsA(isA<NetworkException>()));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should handle DioException and throw a custom exception', () async {
      // Arrange
      when(() => mockDio.get(url)).thenThrow(DioException(
        requestOptions: RequestOptions(path: url),
        error: 'Dio error',
      ));

      // Act
      final call = dataSource.getCities;

      // Assert
      expect(() => call(regionId), throwsA(isA<AppException>()));
      verify(() => mockDio.get(url)).called(1);
    });

    test('should throw UnknownErrorException for unexpected errors', () async {
      // Arrange
      when(() => mockDio.get(url)).thenThrow(Exception('Unexpected error'));

      // Act
      final call = dataSource.getCities;

      // Assert
      expect(() => call(regionId), throwsA(isA<UnknownErrorException>()));
      verify(() => mockDio.get(url)).called(1);
    });
  });
}
