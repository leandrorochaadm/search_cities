import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import '../models/models.dart';

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    super.key,
    required this.onCityTap,
    required this.city,
  });

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
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: Theme.of(context).iconTheme.size,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Text(
                  cityInfo.cityName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: Theme.of(context).iconTheme.size,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
