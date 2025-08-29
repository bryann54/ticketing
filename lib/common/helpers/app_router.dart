// lib/common/helpers/app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart'; // This will be regenerated

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // ⭐ Add AuthRoute as a top-level route ⭐
        AutoRoute(page: AuthRoute.page, path: '/auth'),

        // Define MainRoute with a specific path if you want to replace it by name
        AutoRoute(page: MainRoute.page, path: '/main', children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: VenuesRoute.page),
          AutoRoute(page: TicketsRoute.page),
          AutoRoute(page: AccountRoute.page),
        ]),
        AutoRoute(page: ShowsRoute.page),
        AutoRoute(page: SeatLayoutRoute.page),
        AutoRoute(page: SeatSelectionRoute.page),
        AutoRoute(page: AddShowRoute.page),
      ];
}
