import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../screens/city_details_screen.dart';

class CityListWidget extends StatelessWidget {
  final List<CityEntity> cities;

  const CityListWidget({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cities.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        final city = cities[index];

        return ListTile(
          title: Text(city.cityName),
          subtitle: Text("${city.saName} (${city.saAcronym})"),
          splashColor: Colors.grey.shade800,
          leading: Icon(
            Icons.location_on,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CityDetailsScreen(city: city),
            ),
          ),
        );
      },
    );
  }
}
