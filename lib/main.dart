// lib/main.dart

import 'package:ticketing/common/helpers/app_router.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:ticketing/common/notifiers/locale_provider.dart';
import 'package:ticketing/common/widgets/global_bloc_observer.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// Auth Bloc and Events
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';

// All other feature Blocs
import 'package:ticketing/features/account/presentation/bloc/account_bloc.dart';
import 'package:ticketing/features/merchant/presentation/bloc/merchant_bloc.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/merchant/presentation/bloc/mpesa_setup_bloc.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: "env/.env");
  } else {
    Bloc.observer = AppGlobalBlocObserver();
    await dotenv.load(fileName: "env/.dev.env");
  }

  await configureDependencies(); // Initialize GetIt
  final localeProvider = LocaleProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => localeProvider),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(create: (context) => getIt<MerchantBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<ShowsBloc>()),
        BlocProvider(create: (context) => getIt<VenuesBloc>()),
        BlocProvider(create: (context) => getIt<AccountBloc>()),
        BlocProvider(create: (context) => getIt<TicketsBloc>()),
        BlocProvider(create: (context) => getIt<MpesaSetupBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final systemUiOverlayStyle =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final localeProvider = Provider.of<LocaleProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: !kReleaseMode,
        title: AppLocalizations.getString(context, 'appName'),
        routerConfig: _appRouter.config(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
        ],
        locale: localeProvider.locale,
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: ThemeMode.system,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.dark,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[500],
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 24),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
