import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MainRoute.page, initial: true, children: [
          AutoRoute(page: OverviewRoute.page),
          AutoRoute(page: ShowsRoute.page),
          AutoRoute(page: VenuesRoute.page),
          AutoRoute(page: AccountRoute.page)
        ]),
      ];
}
