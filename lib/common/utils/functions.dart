import 'package:ticketing/core/errors/failures.dart';

String getErrorMessage(Failure failure) {
  if (failure is ServerFailure) {
    return 'Server Error: ${failure.badResponse}';
  } else if (failure is ConnectionFailure) {
    return 'No internet connection. Please check your network.';
  } else if (failure is ClientFailure) {
    return 'Client Error: ${failure.error}';
  } else if (failure is GeneralFailure) {
    return 'Error: ${failure.error}';
  }
  return 'An unknown error occurred.';
}
