import 'package:flutter/material.dart';

import '../../domain/entities/city_entity.dart';
import '../models/models.dart';

class CityDetailsScreen extends StatelessWidget {
  final CityEntity city;

  const CityDetailsScreen({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    final cityDetails = city.toCityDetails();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Cidade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cityDetails.cityName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Estado: ${cityDetails.stateName} (${cityDetails.stateAcronym})",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Details Section
            _buildDetailItem(
              context: context,
              icon: Icons.code,
              label: "Código do Município",
              value: cityDetails.cityId.toString(),
            ),
            _buildDetailItem(
              context: context,
              icon: Icons.location_on,
              label: "Microrregião",
              value: cityDetails.microregionName,
            ),
            _buildDetailItem(
              context: context,
              icon: Icons.map,
              label: "Mesorregião",
              value: cityDetails.mesoregionName,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 32.0,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
