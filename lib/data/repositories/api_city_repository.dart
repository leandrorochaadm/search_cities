import 'dart:developer';

import '../../core/core.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/cities_repository.dart';
import '../sources/cities_data_source.dart';

class ApiCitiesRepository implements CitiesRepository {
  final CitiesDataSource _citiesDataSource;

  ApiCitiesRepository(this._citiesDataSource);
  @override
  Future<List<CityEntity>> getCities() async {
    try {
      final models = await _citiesDataSource.getCities();
      return models
          .map<CityEntity>((cityModel) => cityModel.toEntity())
          .toList();
    } on Exception catch (e, s) {
      log('Error fetching cities', error: e, stackTrace: s);
      // Transformando a exceção em uma falha
      final failure = Failure.fromException(e);
      throw failure;
    } catch (e, s) {
      log('Error fetching cities', error: e, stackTrace: s);
      rethrow;
    }
  }
}
