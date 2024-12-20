import 'dart:developer';

import '../../domain/domain.dart';
import '../../domain/repositories/regions_repository.dart';
import '../sources/regions_data_source.dart';

class ApiRegionsRepository implements RegionsRepository {
  final RegionsDataSource regionsDataSource;

  ApiRegionsRepository(this.regionsDataSource);

  @override
  Future<List<RegionEntity>> getRegions() async {
    try {
      final models = await regionsDataSource.getRegions();
      return models
          .map<RegionEntity>((regionModel) => regionModel.toEntity())
          .toList();
    } catch (e, s) {
      log('Error fetching regions', error: e, stackTrace: s);
      rethrow;
    }
  }
}
