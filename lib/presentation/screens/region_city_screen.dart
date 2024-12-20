import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/domain.dart';
import '../presentation.dart';
import '../widgets/widgets.dart';

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
                      RegionDropdownWidget(
                          regions: state.regions,
                          selectedRegionId: state.selectedRegionId),
                      if (state.cities != null)
                        Expanded(
                          child: CityListWidget(cities: state.cities!),
                        ),
                      if (state.cities == null)
                        Expanded(
                            child: Center(
                                child: Text(
                          "Selecione um estado,\nno campo acima.",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ))),
                    ],
                  );
                } else if (state is RegionCityError) {
                  return ErrorCustomWidget(
                      message: state.message,
                      onRetry: () {
                        context.read<RegionCityBloc>().add(FetchRegionsEvent());
                      });
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
