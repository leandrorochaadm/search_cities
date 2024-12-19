import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import '../models/city_info.dart';
import 'city_details_screen.dart';

class CityScreen extends StatelessWidget {
  const CityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityBloc(context.read<GetCitiesUseCase>())..add(FetchCitiesEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text("Cidades do Brasil")),
        body: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoading) {
              // Exibe o indicador de carregamento
              return Center(child: CircularProgressIndicator());
            } else if (state is CityLoaded) {
              // Exibe a lista de cidades
              return ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  final city = state.cities[index];
                  final cityInfo = city.toCityInfo();
                  return ListTile(
                    title: Text(cityInfo.cityName),
                    subtitle: Text(
                        "${cityInfo.stateName} (${cityInfo.stateAcronym})"),
                    onTap: () {
                      // Navegação para a tela de detalhes com a entidade
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityDetailsScreen(city: city),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is CityError) {
              // Exibe uma mensagem de erro com um botão para tentar novamente
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Dispara o evento para tentar carregar novamente
                        context.read<CityBloc>().add(FetchCitiesEvent());
                      },
                      child: Text("Tentar novamente"),
                    ),
                  ],
                ),
              );
            } else {
              // Estado inesperado
              return Center(child: Text("Ocorreu um erro inesperado."));
            }
          },
        ),
      ),
    );
  }
}
