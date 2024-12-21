import 'package:flutter/material.dart';

import 'core/core.dart';
import 'presentation/presentation.dart';

void main() {
  runApp(
    AppProviders(
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
