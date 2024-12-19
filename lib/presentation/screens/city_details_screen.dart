import 'package:flutter/material.dart';

import '../../domain/entities/city_entity.dart';

class CityDetailsScreen extends StatelessWidget {
  final CityEntity city;

  const CityDetailsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(city.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome do Município: ${city.name}"),
            Text(
                "Estado: ${city.microregion?.mesoregion?.sa?.name ?? "Unknown"}"),
            Text(
                "Sigla do Estado: ${city.microregion?.mesoregion?.sa?.acronym ?? "Unknown"}"),
            Text("Código do Município (ID): ${city.id}"),
            Text("Microrregião: ${city.microregion?.name ?? "Unknown"}"),
            Text(
                "Mesorregião: ${city.microregion?.mesoregion?.name ?? "Unknown"}"),
          ],
        ),
      ),
    );
  }
}
