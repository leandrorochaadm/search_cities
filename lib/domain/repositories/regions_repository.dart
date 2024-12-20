import '../domain.dart';

abstract class RegionsRepository {
  Future<List<RegionEntity>> getRegions();
}
