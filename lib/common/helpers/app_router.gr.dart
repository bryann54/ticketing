// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;
import 'package:ticketing/features/account/presentation/pages/account_screen.dart'
    as _i1;
import 'package:ticketing/features/auth/presentation/pages/auth_screen.dart'
    as _i3;
import 'package:ticketing/features/auth/presentation/pages/login_screen.dart'
    as _i5;
import 'package:ticketing/features/auth/presentation/pages/register_screen.dart'
    as _i9;
import 'package:ticketing/features/auth/presentation/pages/splash_screen.dart'
    as _i14;
import 'package:ticketing/features/home/presentation/pages/home_screen.dart'
    as _i4;
import 'package:ticketing/features/merchant/presentation/pages/merchant_onboarding_screen.dart'
    as _i7;
import 'package:ticketing/features/merchant/presentation/pages/payment_setup_screen.dart'
    as _i8;
import 'package:ticketing/features/shows/data/models/show_model.dart' as _i20;
import 'package:ticketing/features/shows/presentation/pages/add_show_screen.dart'
    as _i2;
import 'package:ticketing/features/shows/presentation/pages/show_details_screen.dart'
    as _i12;
import 'package:ticketing/features/shows/presentation/pages/shows_screen.dart'
    as _i13;
import 'package:ticketing/features/tickets/presentation/pages/ticket_scanning_screen.dart'
    as _i15;
import 'package:ticketing/features/tickets/presentation/pages/tickets_screen.dart'
    as _i16;
import 'package:ticketing/features/venues/data/models/seat_row_model.dart'
    as _i22;
import 'package:ticketing/features/venues/data/models/venue_model.dart' as _i21;
import 'package:ticketing/features/venues/presentation/pages/seat_selection_screen.dart'
    as _i11;
import 'package:ticketing/features/venues/presentation/pages/venues_screen.dart'
    as _i17;
import 'package:ticketing/features/venues/presentation/widgets/seat_map_section_view.dart'
    as _i10;
import 'package:ticketing/main_screen.dart' as _i6;

/// generated route for
/// [_i1.AccountScreen]
class AccountRoute extends _i18.PageRouteInfo<void> {
  const AccountRoute({List<_i18.PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountScreen();
    },
  );
}

/// generated route for
/// [_i2.AddShowScreen]
class AddShowRoute extends _i18.PageRouteInfo<AddShowRouteArgs> {
  AddShowRoute({
    _i19.Key? key,
    _i20.ShowModel? showToEdit,
    required List<_i21.VenueModel> venues,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         AddShowRoute.name,
         args: AddShowRouteArgs(
           key: key,
           showToEdit: showToEdit,
           venues: venues,
         ),
         initialChildren: children,
       );

  static const String name = 'AddShowRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddShowRouteArgs>();
      return _i2.AddShowScreen(
        key: args.key,
        showToEdit: args.showToEdit,
        venues: args.venues,
      );
    },
  );
}

class AddShowRouteArgs {
  const AddShowRouteArgs({this.key, this.showToEdit, required this.venues});

  final _i19.Key? key;

  final _i20.ShowModel? showToEdit;

  final List<_i21.VenueModel> venues;

  @override
  String toString() {
    return 'AddShowRouteArgs{key: $key, showToEdit: $showToEdit, venues: $venues}';
  }
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i18.PageRouteInfo<void> {
  const AuthRoute({List<_i18.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.AuthScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginScreen]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginScreen();
    },
  );
}

/// generated route for
/// [_i6.MainScreen]
class MainRoute extends _i18.PageRouteInfo<void> {
  const MainRoute({List<_i18.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i6.MainScreen();
    },
  );
}

/// generated route for
/// [_i7.MerchantOnboardingScreen]
class MerchantOnboardingRoute extends _i18.PageRouteInfo<void> {
  const MerchantOnboardingRoute({List<_i18.PageRouteInfo>? children})
    : super(MerchantOnboardingRoute.name, initialChildren: children);

  static const String name = 'MerchantOnboardingRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.MerchantOnboardingScreen();
    },
  );
}

/// generated route for
/// [_i8.PaymentSetupScreen]
class PaymentSetupRoute extends _i18.PageRouteInfo<void> {
  const PaymentSetupRoute({List<_i18.PageRouteInfo>? children})
    : super(PaymentSetupRoute.name, initialChildren: children);

  static const String name = 'PaymentSetupRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.PaymentSetupScreen();
    },
  );
}

/// generated route for
/// [_i9.RegisterScreen]
class RegisterRoute extends _i18.PageRouteInfo<void> {
  const RegisterRoute({List<_i18.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i9.RegisterScreen();
    },
  );
}

/// generated route for
/// [_i10.SeatLayoutScreen]
class SeatLayoutRoute extends _i18.PageRouteInfo<SeatLayoutRouteArgs> {
  SeatLayoutRoute({
    _i19.Key? key,
    required _i21.VenueModel venue,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         SeatLayoutRoute.name,
         args: SeatLayoutRouteArgs(key: key, venue: venue),
         initialChildren: children,
       );

  static const String name = 'SeatLayoutRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeatLayoutRouteArgs>();
      return _i10.SeatLayoutScreen(key: args.key, venue: args.venue);
    },
  );
}

class SeatLayoutRouteArgs {
  const SeatLayoutRouteArgs({this.key, required this.venue});

  final _i19.Key? key;

  final _i21.VenueModel venue;

  @override
  String toString() {
    return 'SeatLayoutRouteArgs{key: $key, venue: $venue}';
  }
}

/// generated route for
/// [_i11.SeatSelectionScreen]
class SeatSelectionRoute extends _i18.PageRouteInfo<SeatSelectionRouteArgs> {
  SeatSelectionRoute({
    _i19.Key? key,
    required String title,
    required List<_i22.SeatRowModel> seatRows,
    List<_i18.PageRouteInfo>? children,
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

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SeatSelectionRouteArgs>();
      return _i11.SeatSelectionScreen(
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

  final _i19.Key? key;

  final String title;

  final List<_i22.SeatRowModel> seatRows;

  @override
  String toString() {
    return 'SeatSelectionRouteArgs{key: $key, title: $title, seatRows: $seatRows}';
  }
}

/// generated route for
/// [_i12.ShowDetailsScreen]
class ShowDetailsRoute extends _i18.PageRouteInfo<ShowDetailsRouteArgs> {
  ShowDetailsRoute({
    _i19.Key? key,
    required _i20.ShowModel show,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         ShowDetailsRoute.name,
         args: ShowDetailsRouteArgs(key: key, show: show),
         initialChildren: children,
       );

  static const String name = 'ShowDetailsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ShowDetailsRouteArgs>();
      return _i12.ShowDetailsScreen(key: args.key, show: args.show);
    },
  );
}

class ShowDetailsRouteArgs {
  const ShowDetailsRouteArgs({this.key, required this.show});

  final _i19.Key? key;

  final _i20.ShowModel show;

  @override
  String toString() {
    return 'ShowDetailsRouteArgs{key: $key, show: $show}';
  }
}

/// generated route for
/// [_i13.ShowsScreen]
class ShowsRoute extends _i18.PageRouteInfo<void> {
  const ShowsRoute({List<_i18.PageRouteInfo>? children})
    : super(ShowsRoute.name, initialChildren: children);

  static const String name = 'ShowsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.ShowsScreen();
    },
  );
}

/// generated route for
/// [_i14.SplashScreen]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashScreen();
    },
  );
}

/// generated route for
/// [_i15.TicketScanningScreen]
class TicketScanningRoute extends _i18.PageRouteInfo<TicketScanningRouteArgs> {
  TicketScanningRoute({
    _i19.Key? key,
    required _i20.ShowModel show,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         TicketScanningRoute.name,
         args: TicketScanningRouteArgs(key: key, show: show),
         initialChildren: children,
       );

  static const String name = 'TicketScanningRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketScanningRouteArgs>();
      return _i15.TicketScanningScreen(key: args.key, show: args.show);
    },
  );
}

class TicketScanningRouteArgs {
  const TicketScanningRouteArgs({this.key, required this.show});

  final _i19.Key? key;

  final _i20.ShowModel show;

  @override
  String toString() {
    return 'TicketScanningRouteArgs{key: $key, show: $show}';
  }
}

/// generated route for
/// [_i16.TicketsScreen]
class TicketsRoute extends _i18.PageRouteInfo<void> {
  const TicketsRoute({List<_i18.PageRouteInfo>? children})
    : super(TicketsRoute.name, initialChildren: children);

  static const String name = 'TicketsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i16.TicketsScreen();
    },
  );
}

/// generated route for
/// [_i17.VenuesScreen]
class VenuesRoute extends _i18.PageRouteInfo<void> {
  const VenuesRoute({List<_i18.PageRouteInfo>? children})
    : super(VenuesRoute.name, initialChildren: children);

  static const String name = 'VenuesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i17.VenuesScreen();
    },
  );
}
