// lib/core/api_client/endpoints/api_endpoints.dart

class ApiEndpoints {
  // Auth Endpoints
  static const String authSignIn = '/auth/login';
  static const String authSignUp = '/auth/register';
  static const String authGoogleCallback = '/auth/google/callback';
  static const String authSignOut = '/auth/logout';
  static const String authResetPassword = '/auth/password/reset';
  static const String authMe = '/auth/me';

  // Venues Endpoints
  static const String venuesAll = '/venues/create/';
  static String venueById(String id) => '$venuesAll$id/';
  static const String venuesCreate = '/venues/create/';

  // Shows Endpoints
  static const String showsAll = '/shows/create/';
  static String showsById(String id) => '$showsAll$id/';
  static const String showsCreate = '/shows/create/';
  static const String showsTicketsBulkCreate = '/shows/tickets/bulk-create/';

  // Seat Rows Endpoints
  static const String venuesSeatRowsCreate = '/venues/seat-rows/create/';
  static String venuesSeatRowsById(String id) => '/venues/seat-rows/$id/';
  static const String venuesSeatRowsUpdate = '/venues/seat-rows/update/';

  // Seats Endpoints
  static const String venuesSeatsCreate = '/venues/seats/create/';
  static String venuesSeatsById(String id) => '/venues/seats/$id/';
  static const String venuesSeatsUpdate = '/venues/seats/update/';
}
