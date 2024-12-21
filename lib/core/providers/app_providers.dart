import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/repositories.dart';
import '../../data/sources/sources.dart';
import '../../domain/use_cases/use_cases.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        ..._dataSourcesProviders,
        ..._repositoriesProviders,
        ..._useCasesProviders,
      ],
      child: child,
    );
  }
}

final _dataSourcesProviders = [
  Provider<RegionsDataSource>(
    create: (context) => RegionsDataSource(context.read<Dio>()),
  ),
  Provider<CitiesDataSource>(
    create: (context) => CitiesDataSource(context.read<Dio>()),
  ),
];

final _repositoriesProviders = [
  Provider<ApiRegionsRepository>(
    create: (context) =>
        ApiRegionsRepository(context.read<RegionsDataSource>()),
  ),
  Provider<ApiCitiesRepository>(
    create: (context) => ApiCitiesRepository(context.read<CitiesDataSource>()),
  ),
];

final _useCasesProviders = [
  Provider<GetRegionsUseCase>(
    create: (context) =>
        GetRegionsUseCase(context.read<ApiRegionsRepository>()),
  ),
  Provider<GetCitiesByRegionUseCase>(
    create: (context) => GetCitiesByRegionUseCase(
      citiesRepository: context.read<ApiCitiesRepository>(),
    ),
  ),
];
