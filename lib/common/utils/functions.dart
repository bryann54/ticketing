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


// String extension to add 'capitalize' method
extension StringCasingExtension on String {
  String capitalize([int start = 0]) {
    if (isEmpty) return this;
    if (start < 0 || start >= length) return this;
    return substring(0, start) +
        substring(start, start + 1).toUpperCase() +
        substring(start + 1);
  }
}
