import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_custom.dart';
import 'data/repositories/repositories.dart';
import 'data/sources/cities_data_source.dart';
import 'data/sources/regions_data_source.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        Provider(create: (context) => RegionsDataSource(context.read<Dio>())),
        Provider(create: (context) => CitiesDataSource(context.read<Dio>())),
        Provider(
            create: (context) =>
                ApiRegionsRepository(context.read<RegionsDataSource>())),
        Provider(
            create: (context) =>
                ApiCitiesRepository(context.read<CitiesDataSource>())),
        Provider(
            create: (context) => GetRegionsUseCase(
                ApiRegionsRepository(context.read<RegionsDataSource>()))),
        Provider(
            create: (context) => GetCitiesByRegionUseCase(
                citiesRepository:
                    ApiCitiesRepository(context.read<CitiesDataSource>()))),
        Provider<GetCitiesByRegionUseCase>(
          create: (context) => GetCitiesByRegionUseCase(
              citiesRepository:
                  ApiCitiesRepository(context.read<CitiesDataSource>())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cidades por estados do Brasil',
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.dark,
      home: const RegionCityScreen(),
    );
  }
}
