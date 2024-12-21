import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:searchcities/core/core.dart';
import 'package:searchcities/domain/domain.dart';
import 'package:searchcities/presentation/blocs/blocs.dart';

class MockGetRegionsUseCase extends Mock implements GetRegionsUseCase {}

class MockGetCitiesByRegionUseCase extends Mock
    implements GetCitiesByRegionUseCase {}

void main() {
  late RegionCityBloc bloc;
  late MockGetRegionsUseCase mockGetRegionsUseCase;
  late MockGetCitiesByRegionUseCase mockGetCitiesByRegionUseCase;

  setUp(() {
    mockGetRegionsUseCase = MockGetRegionsUseCase();
    mockGetCitiesByRegionUseCase = MockGetCitiesByRegionUseCase();
    bloc = RegionCityBloc(
      getRegionsUseCase: mockGetRegionsUseCase,
      getCitiesByRegionUseCase: mockGetCitiesByRegionUseCase,
    );
  });

  group('RegionCityBloc - FetchRegionsEvent', () {
    final mockRegions = [
      RegionEntity(id: 1, name: 'Region 1', acronym: 'R1'),
      RegionEntity(id: 2, name: 'Region 2', acronym: 'R2'),
    ];

    blocTest<RegionCityBloc, RegionCityState>(
      'emits [RegionCityLoading, RegionsLoaded] when FetchRegionsEvent is successful',
      build: () {
        when(() => mockGetRegionsUseCase())
            .thenAnswer((_) async => Right(mockRegions));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchRegionsEvent()),
      expect: () => [
        RegionCityLoading(),
        RegionsLoaded(regions: mockRegions, cities: null),
      ],
      verify: (_) => verify(() => mockGetRegionsUseCase()).called(1),
    );

    blocTest<RegionCityBloc, RegionCityState>(
      'emits [RegionCityLoading, RegionCityError] when FetchRegionsEvent fails',
      build: () {
        when(() => mockGetRegionsUseCase()).thenAnswer(
            (_) async => Left(Failure.network('Error fetching regions')));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchRegionsEvent()),
      expect: () => [
        RegionCityLoading(),
        RegionCityError('Error fetching regions'),
      ],
      verify: (_) => verify(() => mockGetRegionsUseCase()).called(1),
    );
  });

  group('RegionCityBloc - FetchCitiesByRegionEvent', () {
    final mockCities = [
      CityEntity(
          cityId: 1,
          cityName: 'City 1',
          microregion: 'Microregion 1',
          mesoregion: 'Mesoregion 1',
          saAcronym: 'UF1',
          saName: 'State 1'),
      CityEntity(
          cityId: 2,
          cityName: 'City 2',
          microregion: 'Microregion 2',
          mesoregion: 'Mesoregion 2',
          saAcronym: 'UF2',
          saName: 'State 2'),
    ];

    final mockRegions = [
      RegionEntity(id: 1, name: 'Region 1', acronym: 'R1'),
      RegionEntity(id: 2, name: 'Region 2', acronym: 'R2'),
    ];

    blocTest<RegionCityBloc, RegionCityState>(
      'emits [RegionCityLoading, RegionsLoaded with cities] when FetchCitiesByRegionEvent is successful',
      build: () {
        when(() => mockGetCitiesByRegionUseCase(regionId: 1))
            .thenAnswer((_) async => Right(mockCities));
        return bloc;
      },
      seed: () => RegionsLoaded(regions: mockRegions, cities: null),
      act: (bloc) => bloc.add(FetchCitiesByRegionEvent(1)),
      expect: () => [
        RegionCityLoading(),
        RegionsLoaded(
            regions: mockRegions, cities: mockCities, selectedRegionId: 1),
      ],
      verify: (_) =>
          verify(() => mockGetCitiesByRegionUseCase(regionId: 1)).called(1),
    );

    blocTest<RegionCityBloc, RegionCityState>(
      'emits [RegionCityLoading, RegionCityError] when FetchCitiesByRegionEvent fails',
      build: () {
        when(() => mockGetCitiesByRegionUseCase(regionId: 1)).thenAnswer(
            (_) async => Left(Failure.network('Error fetching cities')));
        return bloc;
      },
      seed: () => RegionsLoaded(regions: mockRegions, cities: null),
      act: (bloc) => bloc.add(FetchCitiesByRegionEvent(1)),
      expect: () => [
        RegionCityLoading(),
        RegionCityError('Error fetching cities'),
      ],
      verify: (_) =>
          verify(() => mockGetCitiesByRegionUseCase(regionId: 1)).called(1),
    );
  });

  group('RegionCityBloc - ClearCitiesEvent', () {
    final mockRegions = [
      RegionEntity(id: 1, name: 'Region 1', acronym: 'R1'),
      RegionEntity(id: 2, name: 'Region 2', acronym: 'R2'),
    ];

    blocTest<RegionCityBloc, RegionCityState>(
      'emits [RegionCityLoading, RegionsLoaded without cities] when ClearCitiesEvent is called',
      build: () {
        when(() => mockGetRegionsUseCase())
            .thenAnswer((_) async => Right(mockRegions));
        return bloc;
      },
      act: (bloc) => bloc.add(ClearCitiesEvent()),
      expect: () => [
        RegionCityLoading(),
        RegionsLoaded(regions: mockRegions, cities: null),
      ],
      verify: (_) => verify(() => mockGetRegionsUseCase()).called(1),
    );
  });
}
