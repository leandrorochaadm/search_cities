import 'package:dio/dio.dart';

import '../../core/errors/errors.dart';
import '../models/models.dart';

class CitiesDataSource {
  final Dio dio;

  CitiesDataSource(this.dio);

  Future<List<CityModel>> getCities() async {
    try {
      const url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';
      final response = await dio.get(url);

      if (response.statusCode != 200) {
        throw NetworkException('${response.statusCode}');
      }

      return (response.data as List)
          .map((json) => CityModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      // Tratamento de erros específicos do Dio
      throw HandleDioException.call(e);
    } catch (e) {
      throw UnknownErrorException("An unknown error occurred: $e");
    }
  }
}
