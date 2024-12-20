import '../entities/city_entity.dart';

abstract class CitiesRepository {
  Future<List<CityEntity>> getCities(int regionId);
}
