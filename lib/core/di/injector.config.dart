// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/account/data/datasources/account_local_datasource.dart'
    as _i29;
import '../../features/account/data/repositories/account_repository_impl.dart'
    as _i857;
import '../../features/account/domain/repositories/account_repository.dart'
    as _i1067;
import '../../features/account/domain/usecases/change_language_usecase.dart'
    as _i993;
import '../../features/account/presentation/bloc/account_bloc.dart' as _i708;
import '../../features/favourites/data/services/favourites_service.dart'
    as _i354;
import '../../features/favourites/presentation/bloc/favourites_bloc.dart'
    as _i624;
import '../../features/favourites/presentation/pages/favourites)screen.dart'
    as _i825;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/home/presentation/pages/home_screen.dart' as _i298;
import '../../features/shows/data/datasources/shows_remote_datasource.dart'
    as _i65;
import '../../features/shows/data/repositories/shows_repository_impl.dart'
    as _i57;
import '../../features/shows/domain/repositories/shows_repository.dart'
    as _i153;
import '../../features/shows/domain/usecases/get_shows_usecase.dart' as _i630;
import '../../features/shows/presentation/bloc/shows_bloc.dart' as _i204;
import '../../features/venues/data/datasources/venues_remote_datasource.dart'
    as _i910;
import '../../features/venues/data/repositories/venues_repository_impl.dart'
    as _i1011;
import '../../features/venues/domain/repositories/venues_repository.dart'
    as _i7;
import '../../features/venues/domain/usecases/get_venues_usecase.dart' as _i627;
import '../../features/venues/presentation/bloc/venues_bloc.dart' as _i884;
import '../../features/venues/presentation/pages/venues_screen.dart' as _i697;
import '../api_client/client/dio_client.dart' as _i758;
import '../api_client/client_provider.dart' as _i546;
import '../storage/storage_preference_manager.dart' as _i934;
import 'module_injector.dart' as _i759;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModules = _$RegisterModules();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModules.prefs(),
      preResolve: true,
    );
    gh.lazySingleton<_i354.FavouritesService>(() => _i354.FavouritesService());
    gh.factory<_i697.VenuesScreen>(
        () => _i697.VenuesScreen(key: gh<_i409.Key>()));
    gh.factory<_i298.HomeScreen>(() => _i298.HomeScreen(key: gh<_i409.Key>()));
    gh.factory<_i825.FavouritesScreen>(
        () => _i825.FavouritesScreen(key: gh<_i409.Key>()));
    gh.factory<String>(
      () => registerModules.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => registerModules.apiKey,
      instanceName: 'ApiKey',
    );
    gh.factory<_i624.FavouritesBloc>(
        () => _i624.FavouritesBloc(gh<_i354.FavouritesService>()));
    gh.lazySingleton<_i934.SharedPreferencesManager>(
        () => _i934.SharedPreferencesManager(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i29.AccountLocalDatasource>(() =>
        _i29.AccountLocalDatasource(gh<_i934.SharedPreferencesManager>()));
    gh.lazySingleton<_i546.ApiClient>(
        () => _i546.ApiClient(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i361.Dio>(
        () => registerModules.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i910.VenuesRemoteDatasource>(
        () => _i910.VenuesRemoteDatasource(gh<_i546.ApiClient>()));
    gh.lazySingleton<_i65.ShowsRemoteDatasource>(
        () => _i65.ShowsRemoteDatasource(gh<_i546.ApiClient>()));
    gh.lazySingleton<_i758.DioClient>(() => _i758.DioClient(
          gh<_i361.Dio>(),
          gh<String>(instanceName: 'BaseUrl'),
        ));
    gh.lazySingleton<_i153.ShowsRepository>(
        () => _i57.ShowsRepositoryImpl(gh<_i65.ShowsRemoteDatasource>()));
    gh.lazySingleton<_i1067.AccountRepository>(
        () => _i857.AccountRepositoryImpl(gh<_i29.AccountLocalDatasource>()));
    gh.lazySingleton<_i993.ChangeLanguageUsecase>(
        () => _i993.ChangeLanguageUsecase(gh<_i1067.AccountRepository>()));
    gh.factory<_i708.AccountBloc>(
        () => _i708.AccountBloc(gh<_i993.ChangeLanguageUsecase>()));
    gh.lazySingleton<_i630.GetShowsUsecase>(
        () => _i630.GetShowsUsecase(gh<_i153.ShowsRepository>()));
    gh.lazySingleton<_i7.VenuesRepository>(
        () => _i1011.VenuesRepositoryImpl(gh<_i910.VenuesRemoteDatasource>()));
    gh.lazySingleton<_i627.GetVenuesUsecase>(
        () => _i627.GetVenuesUsecase(gh<_i7.VenuesRepository>()));
    gh.factory<_i204.ShowsBloc>(
        () => _i204.ShowsBloc(gh<_i630.GetShowsUsecase>()));
    gh.factory<_i884.VenuesBloc>(
        () => _i884.VenuesBloc(gh<_i627.GetVenuesUsecase>()));
    gh.factory<_i202.HomeBloc>(() => _i202.HomeBloc(
          gh<_i630.GetShowsUsecase>(),
          gh<_i627.GetVenuesUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModules extends _i759.RegisterModules {}
