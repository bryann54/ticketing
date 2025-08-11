// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:ticketing/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:ticketing/features/overview/presentation/pages/overview_screen.dart'
    as _i3;
import 'package:ticketing/features/shows/presentation/pages/shows_screen.dart'
    as _i4;
import 'package:ticketing/features/venues/presentation/pages/venues_screen.dart'
    as _i5;
import 'package:ticketing/main_screen.dart' as _i2;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i6.PageRouteInfo<void> {
  const AccountRoute({List<_i6.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}

/// generated route for
/// [_i3.OverviewScreen]
class OverviewRoute extends _i6.PageRouteInfo<void> {
  const OverviewRoute({List<_i6.PageRouteInfo>? children})
    : super(OverviewRoute.name, initialChildren: children);

  static const String name = 'OverviewRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.OverviewScreen();
    },
  );
}

/// generated route for
/// [_i4.ShowsScreen]
class ShowsRoute extends _i6.PageRouteInfo<void> {
  const ShowsRoute({List<_i6.PageRouteInfo>? children})
    : super(ShowsRoute.name, initialChildren: children);

  static const String name = 'ShowsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.ShowsScreen();
    },
  );
}

/// generated route for
/// [_i5.VenuesScreen]
class VenuesRoute extends _i6.PageRouteInfo<void> {
  const VenuesRoute({List<_i6.PageRouteInfo>? children})
    : super(VenuesRoute.name, initialChildren: children);

  static const String name = 'VenuesRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.VenuesScreen();
    },
  );
}
