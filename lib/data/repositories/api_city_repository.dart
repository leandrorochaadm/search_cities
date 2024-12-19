import '../../domain/entities/city_entity.dart';
import '../../domain/repositories/cities_repository.dart';
import '../sources/cities_data_source.dart';

class ApiCitiesRepository implements CitiesRepository {
  final CitiesDataSource _citiesDataSource;

  ApiCitiesRepository(this._citiesDataSource);
  @override
  Future<List<CityEntity>> getCities() async {
    final models = await _citiesDataSource.getCities();

    final entities = models
        .map<CityEntity>((cityModel) => CityEntity.fromModel(cityModel))
        .toList();
    return entities;
  }
}
