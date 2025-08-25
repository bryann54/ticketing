// main_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:ticketing/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_bloc.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_bloc.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeBloc>()),
        BlocProvider(create: (context) => getIt<ShowsBloc>()),
        BlocProvider(create: (context) => getIt<VenuesBloc>()),
        BlocProvider(create: (context) => getIt<AccountBloc>()),
        BlocProvider(
            create: (context) =>
                getIt<FavouritesBloc>()..add(LoadFavourites())),
      ],
      child: AutoTabsScaffold(
          lazyLoad: false,
          routes: const [
            HomeRoute(),
            VenuesRoute(),
            TicketsRoute(),
            AccountRoute()
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.getString(context, 'home'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.location_city),  
                  label: AppLocalizations.getString(context, 'venues'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.movie_filter),
                  label: AppLocalizations.getString(context, 'tickets'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                  label: AppLocalizations.getString(context, 'account'),
                ),
              ],
              currentIndex: tabsRouter.activeIndex,
              selectedItemColor: Colors.blue,
              onTap: tabsRouter.setActiveIndex,
            );
          }),
    );
  }
}
