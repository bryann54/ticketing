// // lib/common/utils/pkce_generator.dart

// import 'dart:convert';
// import 'dart:math';
// import 'package:crypto/crypto.dart'; // Make sure you have the 'crypto' package in pubspec.yaml

// /// Generates a random string suitable for a code verifier.
// String generateCodeVerifier() {
//   final Random _random = Random.secure();
//   final List<int> _bytes = List<int>.generate(32, (_) => _random.nextInt(256));
//   return base64Url.encode(_bytes).replaceAll('=', '');
// }

// /// Generates a code challenge from a code verifier using S256 method.
// String generateCodeChallenge(String codeVerifier) {
//   final List<int> _bytes = utf8.encode(codeVerifier);
//   final Digest _digest = sha256.convert(_bytes);
//   return base64Url.encode(_digest.bytes).replaceAll('=', '');
// }
