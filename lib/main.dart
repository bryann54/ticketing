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

// Import your Auth Bloc and Events
import 'package:ticketing/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_event.dart';
import 'package:ticketing/features/auth/presentation/bloc/auth_state.dart';
import 'package:ticketing/features/auth/presentation/pages/auth_screen.dart'; // Import AuthScreen

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
        // Provide AuthBloc at the root level
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(const CheckAuthStatusEvent()),
        ),
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
            ? SystemUiOverlayStyle.light // Light icons for dark theme
            : SystemUiOverlayStyle.dark; // Dark icons for light theme

    final localeProvider = Provider.of<LocaleProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: BlocBuilder<AuthBloc, AuthState>( // Use BlocBuilder to react to auth state changes
        builder: (context, authState) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: !kReleaseMode,
            title: AppLocalizations.getString(context, 'appName'),
            routerConfig: _appRouter.config(), // Use the router configuration
            localizationsDelegates: const [ // Made const for efficiency
              
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [ // Made const for efficiency
              Locale('en'),
              Locale('es'),
              Locale('fr'),
            ],
            locale: localeProvider.locale,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData( // Made const
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey,
                selectedIconTheme: IconThemeData(size: 28),
                unselectedIconTheme: IconThemeData(size: 24),
                type: BottomNavigationBarType.fixed,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.grey[900],
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey[500],
                selectedIconTheme: const IconThemeData(size: 28),
                unselectedIconTheme: const IconThemeData(size: 24),
                type: BottomNavigationBarType.fixed,
              ),
            ),
            themeMode: ThemeMode.system,
            // Conditional routing based on authentication state
            builder: (context, child) {
              if (authState.status == AuthStatus.loading || authState.status == AuthStatus.initial) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(), // Show loading indicator while checking auth
                  ),
                );
              } else if (authState.status == AuthStatus.authenticated) {
                return child!; // Show the main app if authenticated
              } else {
                return const AuthScreen(); // Show AuthScreen if unauthenticated or error
              }
            },
          );
        },
      ),
    );
  }
}