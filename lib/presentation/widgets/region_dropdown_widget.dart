import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../blocs/blocs.dart';

class RegionDropdownWidget extends StatelessWidget {
  final List<RegionEntity> regions;
  final int? selectedRegionId;

  const RegionDropdownWidget({
    super.key,
    required this.regions,
    this.selectedRegionId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Selecione um estado",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        itemHeight: 72,
        underline: SizedBox.shrink(),
        value: selectedRegionId,
        items: [
          DropdownMenuItem<int>(
            value: null,
            alignment: AlignmentDirectional.center,
            child: ListTile(
              title: Text(
                ""
                "Selecione um estado",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              leading: Icon(Icons.clear),
              tileColor: Colors.grey.shade600,
            ),
          ),
          ...regions.map(
            (region) {
              return DropdownMenuItem(
                value: region.id,
                alignment: AlignmentDirectional.center,
                child: ListTile(
                  title: Text("${region.name} (${region.acronym})"),
                  splashColor: Colors.grey.shade800,
                  leading: Icon(Icons.my_location),
                ),
              );
            },
          ),
        ],
        onChanged: (regionId) {
          context.read<RegionCityBloc>().add(
                regionId != null
                    ? FetchCitiesByRegionEvent(regionId)
                    : ClearCitiesEvent(),
              );
        },
      ),
    );
  }
}
