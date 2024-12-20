import 'package:dio/dio.dart';

import '../../core/errors/errors.dart';
import '../models/models.dart';

class RegionsDataSource {
  final Dio dio;

  RegionsDataSource(this.dio);

  Future<List<RegionModel>> getRegions() async {
    try {
      final url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados?orderBy=nome';
      final response = await dio.get(url);

      if (response.statusCode != 200) {
        throw NetworkException('${response.statusCode}');
      }

      return (response.data as List)
          .map((json) => RegionModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      // Tratamento de erros específicos do Dio
      throw HandleDioException.call(e);
    } on AppException catch (_) {
      rethrow;
    } catch (e) {
      throw UnknownErrorException("An unknown error occurred: $e");
    }
  }
}
