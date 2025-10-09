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
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
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
import '../../features/auth/data/datasources/auth_remoteDataSource.dart'
    as _i167;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_epository.dart' as _i626;
import '../../features/auth/domain/usecases/auth_usecases.dart' as _i46;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/home/presentation/bloc/home_bloc.dart' as _i202;
import '../../features/home/presentation/pages/home_screen.dart' as _i298;
import '../../features/merchant/data/datasources/merchant_remote_datasource.dart'
    as _i517;
import '../../features/merchant/data/datasources/mpesa_remote_datasource.dart'
    as _i778;
import '../../features/merchant/data/repositories/merchant_repository_impl.dart'
    as _i458;
import '../../features/merchant/data/repositories/mpesa_repository_impl.dart'
    as _i153;
import '../../features/merchant/domain/repositories/merchant_repository.dart'
    as _i90;
import '../../features/merchant/domain/repositories/mpesa_repository.dart'
    as _i452;
import '../../features/merchant/domain/usecases/add_mpesa_details.dart'
    as _i661;
import '../../features/merchant/domain/usecases/create_merchant_usecase.dart'
    as _i909;
import '../../features/merchant/domain/usecases/get_merchant_details_usecase.dart'
    as _i814;
import '../../features/merchant/domain/usecases/update_merchant_usecase.dart'
    as _i788;
import '../../features/merchant/presentation/bloc/merchant_bloc.dart' as _i703;
import '../../features/merchant/presentation/bloc/mpesa_setup_bloc.dart'
    as _i439;
import '../../features/shows/data/datasources/shows_remote_datasource.dart'
    as _i65;
import '../../features/shows/data/repositories/shows_repository_impl.dart'
    as _i57;
import '../../features/shows/domain/repositories/shows_repository.dart'
    as _i153;
import '../../features/shows/domain/usecases/get_shows_usecase.dart' as _i630;
import '../../features/shows/presentation/bloc/shows_bloc.dart' as _i204;
import '../../features/tickets/data/datasources/tickets_remote_data_source.dart'
    as _i116;
import '../../features/tickets/data/repositories/tickets_repository_impl.dart'
    as _i736;
import '../../features/tickets/domain/repositories/tickets_repository.dart'
    as _i1049;
import '../../features/tickets/domain/usecases/tickets_usecases.dart' as _i507;
import '../../features/tickets/presentation/bloc/tickets_bloc.dart' as _i755;
import '../../features/venues/data/datasources/venues_remote_datasource.dart'
    as _i910;
import '../../features/venues/data/repositories/venues_repository_impl.dart'
    as _i1011;
import '../../features/venues/domain/repositories/venues_repository.dart'
    as _i7;
import '../../features/venues/domain/usecases/get_venues_usecase.dart' as _i627;
import '../../features/venues/presentation/bloc/venues_bloc.dart' as _i884;
import '../../features/venues/presentation/pages/venues_screen.dart' as _i697;
import '../api_client/client/api_client.dart' as _i671;
import '../api_client/client/dio_client.dart' as _i758;
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
    gh.lazySingleton<_i558.FlutterSecureStorage>(
        () => registerModules.secureStorage);
    gh.factory<_i298.HomeScreen>(() => _i298.HomeScreen(key: gh<_i409.Key>()));
    gh.factory<_i697.VenuesScreen>(
        () => _i697.VenuesScreen(key: gh<_i409.Key>()));
    gh.factory<String>(
      () => registerModules.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<String>(
      () => registerModules.apiKey,
      instanceName: 'ApiKey',
    );
    gh.lazySingleton<_i934.SharedPreferencesManager>(
        () => _i934.SharedPreferencesManager(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i29.AccountLocalDatasource>(() =>
        _i29.AccountLocalDatasource(gh<_i934.SharedPreferencesManager>()));
    gh.lazySingleton<_i671.ApiClient>(
        () => _i671.ApiClient(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i517.MerchantRemoteDatasource>(
        () => _i517.MerchantRemoteDatasourceImpl(
              gh<_i671.ApiClient>(),
              gh<_i558.FlutterSecureStorage>(),
            ));
    gh.lazySingleton<_i361.Dio>(
        () => registerModules.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i778.MpesaRemoteDatasource>(
        () => _i778.MpesaRemoteDatasourceImpl(
              gh<_i671.ApiClient>(),
              gh<_i558.FlutterSecureStorage>(),
            ));
    gh.lazySingleton<_i116.TicketsRemoteDataSource>(
        () => _i116.TicketsRemoteDataSourceImpl(gh<_i671.ApiClient>()));
    gh.lazySingleton<_i65.ShowsRemoteDatasource>(
        () => _i65.ShowsRemoteDatasource(
              gh<_i671.ApiClient>(),
              gh<_i558.FlutterSecureStorage>(),
            ));
    gh.lazySingleton<_i452.MpesaRepository>(
        () => _i153.MpesaRepositoryImpl(gh<_i778.MpesaRemoteDatasource>()));
    gh.lazySingleton<_i758.DioClient>(() => _i758.DioClient(
          gh<_i361.Dio>(),
          gh<String>(instanceName: 'BaseUrl'),
        ));
    gh.lazySingleton<_i90.MerchantRepository>(() =>
        _i458.MerchantRepositoryImpl(gh<_i517.MerchantRemoteDatasource>()));
    gh.lazySingleton<_i167.AuthRemoteDataSource>(
        () => _i167.AuthRemoteDataSourceImpl(
              gh<_i671.ApiClient>(),
              gh<_i558.FlutterSecureStorage>(),
            ));
    gh.lazySingleton<_i153.ShowsRepository>(
        () => _i57.ShowsRepositoryImpl(gh<_i65.ShowsRemoteDatasource>()));
    gh.lazySingleton<_i1067.AccountRepository>(
        () => _i857.AccountRepositoryImpl(gh<_i29.AccountLocalDatasource>()));
    gh.lazySingleton<_i1049.TicketsRepository>(
        () => _i736.TicketsRepositoryImpl(gh<_i116.TicketsRemoteDataSource>()));
    gh.lazySingleton<_i910.VenuesRemoteDatasource>(
        () => _i910.VenuesRemoteDatasource(gh<_i671.ApiClient>()));
    gh.lazySingleton<_i993.ChangeLanguageUsecase>(
        () => _i993.ChangeLanguageUsecase(gh<_i1067.AccountRepository>()));
    gh.lazySingleton<_i507.ScanTicketUseCase>(
        () => _i507.ScanTicketUseCase(gh<_i1049.TicketsRepository>()));
    gh.lazySingleton<_i507.ValidateTicketUseCase>(
        () => _i507.ValidateTicketUseCase(gh<_i1049.TicketsRepository>()));
    gh.lazySingleton<_i507.GetScannedTicketsUseCase>(
        () => _i507.GetScannedTicketsUseCase(gh<_i1049.TicketsRepository>()));
    gh.lazySingleton<_i507.GetTicketByIdUseCase>(
        () => _i507.GetTicketByIdUseCase(gh<_i1049.TicketsRepository>()));
    gh.factory<_i708.AccountBloc>(
        () => _i708.AccountBloc(gh<_i993.ChangeLanguageUsecase>()));
    gh.lazySingleton<_i630.GetShowsUsecase>(
        () => _i630.GetShowsUsecase(gh<_i153.ShowsRepository>()));
    gh.factory<_i814.GetMerchantDetailsUseCase>(
        () => _i814.GetMerchantDetailsUseCase(gh<_i90.MerchantRepository>()));
    gh.lazySingleton<_i7.VenuesRepository>(
        () => _i1011.VenuesRepositoryImpl(gh<_i910.VenuesRemoteDatasource>()));
    gh.lazySingleton<_i909.CreateMerchantUseCase>(
        () => _i909.CreateMerchantUseCase(gh<_i90.MerchantRepository>()));
    gh.factory<_i788.UpdateMerchantUseCase>(
        () => _i788.UpdateMerchantUseCase(gh<_i90.MerchantRepository>()));
    gh.factory<_i755.TicketsBloc>(() => _i755.TicketsBloc(
          scanTicketUseCase: gh<_i507.ScanTicketUseCase>(),
          validateTicketUseCase: gh<_i507.ValidateTicketUseCase>(),
          getScannedTicketsUseCase: gh<_i507.GetScannedTicketsUseCase>(),
        ));
    gh.lazySingleton<_i626.AuthRepository>(
        () => _i153.AuthRepositoryImpl(gh<_i167.AuthRemoteDataSource>()));
    gh.lazySingleton<_i661.AddMpesaDetails>(
        () => _i661.AddMpesaDetails(gh<_i452.MpesaRepository>()));
    gh.lazySingleton<_i627.GetVenuesUsecase>(
        () => _i627.GetVenuesUsecase(gh<_i7.VenuesRepository>()));
    gh.factory<_i703.MerchantBloc>(() => _i703.MerchantBloc(
          gh<_i909.CreateMerchantUseCase>(),
          gh<_i814.GetMerchantDetailsUseCase>(),
          gh<_i788.UpdateMerchantUseCase>(),
        ));
    gh.factory<_i439.MpesaSetupBloc>(() =>
        _i439.MpesaSetupBloc(addMpesaDetails: gh<_i661.AddMpesaDetails>()));
    gh.lazySingleton<_i46.SignInWithEmailAndPasswordUseCase>(() =>
        _i46.SignInWithEmailAndPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SignUpWithEmailAndPasswordUseCase>(() =>
        _i46.SignUpWithEmailAndPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SignOutUseCase>(
        () => _i46.SignOutUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.GetAuthStateChangesUseCase>(
        () => _i46.GetAuthStateChangesUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.ResetPasswordUseCase>(
        () => _i46.ResetPasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.ChangePasswordUseCase>(
        () => _i46.ChangePasswordUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.VerifyOtpUseCase>(
        () => _i46.VerifyOtpUseCase(gh<_i626.AuthRepository>()));
    gh.lazySingleton<_i46.SendOtpUseCase>(
        () => _i46.SendOtpUseCase(gh<_i626.AuthRepository>()));
    gh.factory<_i204.ShowsBloc>(
        () => _i204.ShowsBloc(gh<_i630.GetShowsUsecase>()));
    gh.factory<_i884.VenuesBloc>(
        () => _i884.VenuesBloc(gh<_i627.GetVenuesUsecase>()));
    gh.factory<_i797.AuthBloc>(() => _i797.AuthBloc(
          signInWithEmailAndPassword:
              gh<_i46.SignInWithEmailAndPasswordUseCase>(),
          signUpWithEmailAndPassword:
              gh<_i46.SignUpWithEmailAndPasswordUseCase>(),
          signOutUseCase: gh<_i46.SignOutUseCase>(),
          getAuthStateChanges: gh<_i46.GetAuthStateChangesUseCase>(),
          resetPasswordUseCase: gh<_i46.ResetPasswordUseCase>(),
          changePasswordUseCase: gh<_i46.ChangePasswordUseCase>(),
          verifyOtpUseCase: gh<_i46.VerifyOtpUseCase>(),
          sendOtpUseCase: gh<_i46.SendOtpUseCase>(),
        ));
    gh.factory<_i202.HomeBloc>(() => _i202.HomeBloc(
          gh<_i153.ShowsRepository>(),
          gh<_i7.VenuesRepository>(),
        ));
    return this;
  }
}

class _$RegisterModules extends _i759.RegisterModules {}
