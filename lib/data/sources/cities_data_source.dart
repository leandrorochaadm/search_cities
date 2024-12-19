import 'package:dio/dio.dart';

import '../../core/errors/handle_dio_exception.dart';
import '../models/city_model.dart';

class CitiesDataSource {
  final Dio _dio;

  CitiesDataSource(this._dio);
  Future<List<CityModel>> getCities() async {
    try {
      const url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';

      final response = await _dio.get<List<Map<String, dynamic>>>(url);

      if (response.data == null) {
        return <CityModel>[]; // Retorna uma lista vazia se os dados forem nulos
      }

      if (response.statusCode == 200) {
        // Convertendo o JSON em uma lista de `MunicipioModel`
        return response.data!.map((json) => CityModel.fromJson(json)).toList();
      } else {
        throw Exception("Error data loading (${response.statusCode})");
      }
    } on DioException catch (e) {
      // Tratamento de erros específicos do Dio
      throw HandleDioException.call(e);
    }
  }
}
