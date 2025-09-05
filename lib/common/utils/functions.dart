import 'package:ticketing/core/errors/failures.dart';

String getErrorMessage(Failure failure) {
  if (failure is ServerFailure) {
    return 'Server Error: ${failure.message}';
  } else if (failure is ConnectionFailure) {
    return 'No internet connection. Please check your network.';
  } else if (failure is ClientFailure) {
    return 'Client Error: ${failure.message}';
  } else if (failure is GeneralFailure) {
    return 'Error: ${failure.message}';
  }
  return 'An unknown error occurred.';
}
