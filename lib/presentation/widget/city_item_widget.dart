import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../models/models.dart';

class CityItemWidget extends StatelessWidget {
  const CityItemWidget(
      {super.key, required this.onCityTap, required this.city});

  final VoidCallback onCityTap;
  final CityEntity city;

  @override
  Widget build(BuildContext context) {
    final cityInfo = city.toCityInfo();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: onCityTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_city,
                size: 40,
                color: Colors.white70,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cityInfo.cityName,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "${cityInfo.stateName} (${cityInfo.stateAcronym})",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.white54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
