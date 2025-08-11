// main_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:ticketing/features/account/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/shows/presentation/bloc/shows_bloc.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_bloc.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ShowsBloc>()),
        BlocProvider(create: (context) => getIt<VenuesBloc>()),
        BlocProvider(create: (context) => getIt<AccountBloc>())
      ],
      child: AutoTabsScaffold(
          lazyLoad: false,
          routes: const [
            OverviewRoute(),
            ShowsRoute(),
            VenuesRoute(),
            AccountRoute()
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.dashboard),
                  label: AppLocalizations.getString(context, 'overview'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.local_activity),
                  label: AppLocalizations.getString(context, 'shows'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.location_city),
                  label: AppLocalizations.getString(context, 'venues'),
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
