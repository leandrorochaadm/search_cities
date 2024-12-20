import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';
import 'city_details_screen.dart';

class RegionCityScreen extends StatelessWidget {
  const RegionCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionCityBloc(
        getRegionsUseCase: context.read<GetRegionsUseCase>(),
        getCitiesByRegionUseCase: context.read<GetCitiesByRegionUseCase>(),
      )..add(FetchRegionsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Regiões e Cidades"),
        ),
        body: BlocBuilder<RegionCityBloc, RegionCityState>(
          builder: (context, state) {
            if (state is RegionCityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RegionsLoaded) {
              return RegionDropdown(regions: state.regions);
            } else if (state is CitiesLoaded) {
              return CityList(cities: state.cities);
            } else if (state is RegionCityError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text("Ocorreu um erro inesperado."));
            }
          },
        ),
      ),
    );
  }
}

class RegionDropdown extends StatelessWidget {
  final List<RegionEntity> regions;

  const RegionDropdown({super.key, required this.regions});

  @override
  Widget build(BuildContext context) {
    // int? selectedRegionId;

    return DropdownButton<int>(
      hint: const Text("Selecione um estado"),
      items: regions
          .map(
            (region) => DropdownMenuItem(
              value: region.id,
              child: Text(region.name),
            ),
          )
          .toList(),
      onChanged: (regionId) {
        // selectedRegionId = regionId;
        if (regionId != null) {
          context
              .read<RegionCityBloc>()
              .add(FetchCitiesByRegionEvent(regionId));
        }
      },
    );
  }
}

class CityList extends StatelessWidget {
  final List<CityEntity> cities;

  const CityList({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];
        return ListTile(
          title: Text(city.cityName),
          subtitle: Text("${city.saName} (${city.saAcronym})"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CityDetailsScreen(
                  city: city,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
