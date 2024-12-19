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
        title: Text(
          'Detalhes da Cidade',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
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
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.0),
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
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Estado: ${cityDetails.stateName} (${cityDetails.stateAcronym})",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Details Section
            _buildDetailItem(
              icon: Icons.code,
              label: "Código do Município",
              value: cityDetails.cityId.toString(),
            ),
            _buildDetailItem(
              icon: Icons.location_on,
              label: "Microrregião",
              value: cityDetails.microregionName,
            ),
            _buildDetailItem(
              icon: Icons.map,
              label: "Mesorregião",
              value: cityDetails.mesoregionName,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[850],
    );
  }

  Widget _buildDetailItem({
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
            color: Colors.white70,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
