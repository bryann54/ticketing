// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:ticketing/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:ticketing/features/favourites/presentation/pages/favourites)screen.dart'
    as _i2;
import 'package:ticketing/features/home/presentation/pages/home_screen.dart'
    as _i3;
import 'package:ticketing/features/shows/presentation/pages/shows_screen.dart'
    as _i7;
import 'package:ticketing/features/tickets/presentation/pages/tickets_screen.dart'
    as _i8;
import 'package:ticketing/features/venues/data/models/seat_row_model.dart'
    as _i13;
import 'package:ticketing/features/venues/data/models/venue_model.dart' as _i12;
import 'package:ticketing/features/venues/presentation/pages/seat_selection_screen.dart'
    as _i6;
import 'package:ticketing/features/venues/presentation/pages/venues_screen.dart'
    as _i9;
import 'package:ticketing/features/venues/presentation/widgets/seat_map_section_view.dart'
    as _i5;
import 'package:ticketing/main_screen.dart' as _i4;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i10.PageRouteInfo<void> {
  const AccountRoute({List<_i10.PageRouteInfo>? children})
      : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.FavouritesScreen]
class FavouritesRoute extends _i10.PageRouteInfo<void> {
  const FavouritesRoute({List<_i10.PageRouteInfo>? children})
      : super(FavouritesRoute.name, initialChildren: children);

  static const String name = 'FavouritesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.FavouritesScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.SeatLayoutScreen]
class SeatLayoutRoute extends _i10.PageRouteInfo<SeatLayoutRouteArgs> {
  SeatLayoutRoute({
    _i11.Key? key,
    required _i12.VenueModel venue,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SeatLayoutRoute.name,
          args: SeatLayoutRouteArgs(key: key, venue: venue),
          initialChildren: children,
        );

  static const String name = 'SeatLayoutRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeatLayoutRouteArgs>();
      return _i5.SeatLayoutScreen(key: args.key, venue: args.venue);
    },
  );
}

class SeatLayoutRouteArgs {
  const SeatLayoutRouteArgs({this.key, required this.venue});

  final _i11.Key? key;

  final _i12.VenueModel venue;

  @override
  String toString() {
    return 'SeatLayoutRouteArgs{key: $key, venue: $venue}';
  }
}

/// generated route for
/// [_i6.SeatSelectionScreen]
class SeatSelectionRoute extends _i10.PageRouteInfo<SeatSelectionRouteArgs> {
  SeatSelectionRoute({
    _i11.Key? key,
    required String title,
    required List<_i13.SeatRowModel> seatRows,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          SeatSelectionRoute.name,
          args: SeatSelectionRouteArgs(
            key: key,
            title: title,
            seatRows: seatRows,
          ),
          initialChildren: children,
        );

  static const String name = 'SeatSelectionRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeatSelectionRouteArgs>();
      return _i6.SeatSelectionScreen(
        key: args.key,
        title: args.title,
        seatRows: args.seatRows,
      );
    },
  );
}

class SeatSelectionRouteArgs {
  const SeatSelectionRouteArgs({
    this.key,
    required this.title,
    required this.seatRows,
  });

  final _i11.Key? key;

  final String title;

  final List<_i13.SeatRowModel> seatRows;

  @override
  String toString() {
    return 'SeatSelectionRouteArgs{key: $key, title: $title, seatRows: $seatRows}';
  }
}

/// generated route for
/// [_i7.ShowsScreen]
class ShowsRoute extends _i10.PageRouteInfo<void> {
  const ShowsRoute({List<_i10.PageRouteInfo>? children})
      : super(ShowsRoute.name, initialChildren: children);

  static const String name = 'ShowsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.ShowsScreen();
    },
  );
}

/// generated route for
/// [_i8.TicketsScreen]
class TicketsRoute extends _i10.PageRouteInfo<void> {
  const TicketsRoute({List<_i10.PageRouteInfo>? children})
      : super(TicketsRoute.name, initialChildren: children);

  static const String name = 'TicketsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.TicketsScreen();
    },
  );
}

/// generated route for
/// [_i9.VenuesScreen]
class VenuesRoute extends _i10.PageRouteInfo<void> {
  const VenuesRoute({List<_i10.PageRouteInfo>? children})
      : super(VenuesRoute.name, initialChildren: children);

  static const String name = 'VenuesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.VenuesScreen();
    },
  );
}
