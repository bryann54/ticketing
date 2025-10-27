import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/common/res/l10n.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Controller is needed for AnimatedNotchBottomBar, even though AutoTabsScaffold
  // manages the actual tab switching. We initialize it with the number of tabs.
  final _notchBottomBarController = NotchBottomBarController(index: 0);

  @override
  void dispose() {
    _notchBottomBarController.dispose();
    super.dispose();
  }

  // Define the bar items
  List<BottomBarItem> get _bottomBarItems => [
        BottomBarItem(
          inActiveItem: const Icon(Icons.home_outlined),
          activeItem: const Icon(Icons.home),
          itemLabel: AppLocalizations.getString(context, 'home'),
        ),
        BottomBarItem(
          inActiveItem: const Icon(Icons.location_city_outlined),
          activeItem: const Icon(Icons.location_city),
          itemLabel: AppLocalizations.getString(context, 'venues'),
        ),
        BottomBarItem(
          inActiveItem: const Icon(Icons.movie_filter_outlined),
          activeItem: const Icon(Icons.movie_filter),
          itemLabel: AppLocalizations.getString(context, 'Events'),
        ),
        BottomBarItem(
          inActiveItem: const Icon(Icons.account_circle_outlined),
          activeItem: const Icon(Icons.account_circle),
          itemLabel: AppLocalizations.getString(context, 'account'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      routes: const [
        HomeRoute(),
        VenuesRoute(),
        TicketsRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        _notchBottomBarController.index = tabsRouter.activeIndex;

        return AnimatedNotchBottomBar(
          notchBottomBarController: _notchBottomBarController,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
              Theme.of(context).colorScheme.surface,
          showLabel: true,
          removeMargins: false,
          bottomBarItems: _bottomBarItems,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
          },
          //
          kIconSize: 24.0,
          kBottomRadius: 28.0,
          notchColor: AppColors.primaryColor,
          itemLabelStyle: TextStyle(
            fontSize: 12.0,
            color: AppColors.primaryColor,
          ),
          showShadow: true,
          shadowElevation: 4.0,
        );
      },
    );
  }
}
