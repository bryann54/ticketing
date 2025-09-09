import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // With the Blocs provided in main.dart, this widget is much cleaner.
    // It no longer needs a MultiBlocProvider and can focus on navigation.
    return AutoTabsScaffold(
      lazyLoad: false,
      routes: const [
        HomeRoute(),
        VenuesRoute(),
        TicketsRoute(),
        AccountRoute(),
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
      },
    );
  }
}
