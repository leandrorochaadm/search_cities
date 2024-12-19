import '../entities/city_entity.dart';
import '../repositories/cities_repository.dart';

class GetCitiesUseCase {
  final CitiesRepository _citiesRepository;

  GetCitiesUseCase(this._citiesRepository);
  Future<List<CityEntity>> call() {
    return _citiesRepository.getCities();
  }
}
