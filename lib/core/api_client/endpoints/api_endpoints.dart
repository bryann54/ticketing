// lib/core/api_client/endpoints/api_endpoints.dart

class ApiEndpoints {
  // Auth Endpoints
  static const String authChangePassword = '/auth/change-password/';
  static const String authLogin = '/auth/login/';
  static const String authMerchantsCreate = '/auth/merchants/create/';
  static const String authMerchantsDarajaCreate =
      '/auth/merchants/daraja/create/';
  static const String authMerchantsDarajaMe = '/auth/merchants/daraja/me/';
  static const String authMerchantsMe = '/auth/merchants/me/';
  static const String authMerchantsUpdate = '/auth/merchants/update/';
  static const String authOtpVerify = '/auth/otp-verify/';
  static const String authOtp = '/auth/otp/';
  static const String authRegister = '/auth/register/';

  // Shows Endpoints
  static const String showsAll = '/shows/all/';
  static String showById(String id) => '/shows/all/$id/';
  static const String showsCreate = '/shows/create/';
  static const String showsTicketTypesCreate = '/shows/ticket-types/create/';
  static String showsTicketTypesByShow(String showId) =>
      '/shows/ticket-types/show/$showId/';
  static String showsTicketTypesById(String id) => '/shows/ticket-types/$id/';
  static const String showsTicketsBulkCreate = '/shows/tickets/bulk-create/';
  static const String showsTicketsBulkOpenShowCreate =
      '/shows/tickets/bulk-open-show-create/';
  static String showsTicketsById(String id) => '/shows/tickets/$id/';

  // Venues Endpoints
  static String venueById(String id) => '/venues/all/$id/';
  static const String venuesCreate = '/venues/create/';
  static const String venuesMerchantVenues = '/venues/merchant/venues/';
  static const String venuesSeatRowsCreate = '/venues/seat-rows/create/';
  static String venuesSeatRowsUpdate(String id) =>
      '/venues/seat-rows/$id/update/';
  static const String venuesSeatsCreate = '/venues/seats/create/';
  static String venuesSeatsUpdate(String id) => '/venues/seats/$id/update/';
}
