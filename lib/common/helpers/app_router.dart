// lib/common/helpers/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: FavouritesRoute.page),
          AutoRoute(page: TicketsRoute.page),
          AutoRoute(page: AccountRoute.page),
        ]),
        AutoRoute(page: ShowsRoute.page),
        AutoRoute(page: SeatLayoutRoute.page),
        AutoRoute(page: SeatSelectionRoute.page),
        AutoRoute(page: AddShowRoute.page),
      ];
}
