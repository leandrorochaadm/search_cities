import 'package:flutter/material.dart';

import '../../domain/entities/city_entity.dart';
import '../widgets/widgets.dart';

class CityDetailsScreen extends StatelessWidget {
  final CityEntity city;

  const CityDetailsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Cidade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Details Section
            CityDetailsItem(
              icon: Icons.location_on,
              label: "Nome do Município",
              value: city.cityName,
            ),
            CityDetailsItem(
              icon: Icons.code,
              label: "Código do Município",
              value: city.cityId.toString(),
            ),
            CityDetailsItem(
              icon: Icons.my_location,
              label: "Nome do Estado",
              value: city.saName,
            ),
            CityDetailsItem(
              icon: Icons.my_location,
              label: "Sigla do Estado",
              value: city.saAcronym,
            ),
            CityDetailsItem(
              icon: Icons.location_city,
              label: "Microrregião",
              value: city.microregion,
            ),
            CityDetailsItem(
              icon: Icons.map,
              label: "Mesorregião",
              value: city.mesoregion,
            ),
          ],
        ),
      ),
    );
  }
}
