import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';
import 'city_details_screen.dart';

class RegionCityScreen extends StatelessWidget {
  const RegionCityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => RegionCityBloc(
          getRegionsUseCase: context.read<GetRegionsUseCase>(),
          getCitiesByRegionUseCase: context.read<GetCitiesByRegionUseCase>(),
        )..add(FetchRegionsEvent()),
        child: Scaffold(
          appBar: AppBar(title: const Text("Estados e Cidades")),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<RegionCityBloc, RegionCityState>(
              builder: (context, state) {
                if (state is RegionCityLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RegionsLoaded) {
                  return Column(
                    children: [
                      RegionDropdown(regions: state.regions),
                      if (state.cities != null)
                        Expanded(
                          child: CityList(cities: state.cities!),
                        ),
                    ],
                  );
                } else if (state is RegionCityError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(
                      child: Text("Ocorreu um erro inesperado."));
                }
              },
            ),
          ),
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
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: DropdownButton<int>(
        isExpanded: true,
        hint: const Text("Selecione um estado"),
        itemHeight: 72,
        underline: SizedBox.shrink(),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        style: Theme.of(context).textTheme.bodyLarge,
        items: regions.map(
          (region) {
            return DropdownMenuItem(
              value: region.id,
              alignment: AlignmentDirectional.center,
              child: ListTile(
                title: Text("${region.name} (${region.acronym})"),
                splashColor: Colors.grey.shade800,
                leading: Icon(Icons.location_on),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            );
          },
        ).toList(),
        onChanged: (regionId) {
          if (regionId != null) {
            context
                .read<RegionCityBloc>()
                .add(FetchCitiesByRegionEvent(regionId));
          }
        },
      ),
    );
  }
}

class CityList extends StatelessWidget {
  final List<CityEntity> cities;

  const CityList({super.key, required this.cities});

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
