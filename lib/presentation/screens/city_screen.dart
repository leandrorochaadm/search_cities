import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/use_cases.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'city_details_screen.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityBloc(context.read<GetCitiesUseCase>())..add(FetchCitiesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Cidades por estado do Brasil")),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 6.0,
          ),
          child: BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              if (state is CityLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CityLoaded) {
                return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.groupedCities.keys.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final stateName = state.groupedCities.keys.elementAt(index);
                    final cities = state.groupedCities[stateName]!;

                    return ExpansionTile(
                      title: Text(stateName),
                      children: cities.map((city) {
                        return CityItemWidget(
                          city: city,
                          onCityTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CityDetailsScreen(city: city),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                );
              } else if (state is CityError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 50.0,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CityBloc>().add(FetchCitiesEvent());
                        },
                        child: const Text("Tentar novamente"),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Ocorreu um erro inesperado."),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
