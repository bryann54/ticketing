// lib/common/helpers/app_router.dart

import 'package:auto_route/auto_route.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Splash screen as the initial route
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),

        // Auth screens
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(
            page: MerchantOnboardingRoute.page, path: '/merchant-onboarding'),
        AutoRoute(page: PaymentSetupRoute.page, path: '/payment-setup'),

        // Main route with tabs
        AutoRoute(
          page: MainRoute.page,
          path: '/main',
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

        // Other routes
        AutoRoute(page: ShowsRoute.page, path: '/shows'),
        AutoRoute(page: SeatLayoutRoute.page, path: '/seat-layout'),
        AutoRoute(page: SeatSelectionRoute.page, path: '/seat-selection'),
        AutoRoute(page: AddShowRoute.page, path: '/add-show'),
      ];
}
