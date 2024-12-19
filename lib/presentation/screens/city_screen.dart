import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_cities_use_case.dart';
import '../blocs/city_bloc.dart';
import '../blocs/city_event.dart';
import '../blocs/city_state.dart';
import '../widget/city_item_widget.dart';
import 'city_details_screen.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityBloc(context.read<GetCitiesUseCase>())..add(FetchCitiesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cidades do Brasil",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.white,
        ),
        backgroundColor: Colors.grey[850],
        body: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            // Construção da interface com base no estado
            if (state is CityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GroupedCitiesLoaded) {
              // Exibe os dados agrupados
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.groupedCities.keys.length,
                itemBuilder: (context, index) {
                  final stateName = state.groupedCities.keys.elementAt(index);
                  final cities = state.groupedCities[stateName]!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    child: Card(
                      color: Colors.grey[900],
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            stateName,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          iconColor: Colors.white70,
                          collapsedIconColor: Colors.white70,
                          // collapsedBackgroundColor: Colors.redAccent,
                          backgroundColor: Colors.grey[800],
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
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
                        ),
                      ),
                    ),
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
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CityBloc>().add(FetchCitiesEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                      ),
                      child: const Text("Tentar novamente"),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("Ocorreu um erro inesperado."));
            }
          },
        ),
      ),
    );
  }
}
