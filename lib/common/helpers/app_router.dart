import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Main route with tabs
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: HomeRoute.page,
              path: 'home',
              initial: true,
            ),
            AutoRoute(page: VenuesRoute.page, path: 'venues'),
            AutoRoute(page: TicketsRoute.page, path: 'tickets'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
      
        AutoRoute(page: ShowsRoute.page, path: '/shows'),
        AutoRoute(page: SeatLayoutRoute.page, path: '/seat-layout'),
        AutoRoute(page: SeatSelectionRoute.page, path: '/seat-selection'),
        AutoRoute(page: AddShowRoute.page, path: '/add-show'),
      ];
}
