import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_custom.dart';
import 'data/repositories/api_city_repository.dart';
import 'data/sources/cities_data_source.dart';
import 'domain/domain.dart';
import 'presentation/presentation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<Dio>(create: (_) => Dio()),
        Provider<GetCitiesUseCase>(
          create: (context) => GetCitiesUseCase(
            ApiCitiesRepository(
              CitiesDataSource(context.read<Dio>()),
            ),
          ),
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
      title: 'Cidades do Brasil',
      debugShowCheckedModeBanner: false,
      theme: ThemeCustom.dark,
      home: const CityScreen(),
    );
  }
}
