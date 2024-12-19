import 'package:dio/dio.dart';

import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/cities_repository.dart';
import '../models/models.dart';

class ApiCitiesRepository implements CitiesRepository {
  final Dio _dio;

  ApiCitiesRepository(this._dio);
  @override
  Future<List<CityEntity>> getCities() async {
    const url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/municipios';

    final response = await _dio.get<List<Map<String, dynamic>>>(url);

    if (response.data == null) {
      return <CityEntity>[]; // Retorna uma lista vazia se os dados forem nulos
    }

    return response.data!
        .map((json) => CityEntity.fromModel(CityModel.fromJson(json)))
        .toList();
  }
}
