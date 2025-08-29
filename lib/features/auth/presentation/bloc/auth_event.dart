// lib/features/auth/presentation/bloc/auth_event.dart

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

// Add more events as needed, e.g.:
// class SignInWithEmailAndPasswordEvent extends AuthEvent {
//   final String email;
//   final String password;
//   const SignInWithEmailAndPasswordEvent({required this.email, required this.password});
//   @override
//   List<Object> get props => [email, password];
// }

// class SignUpEvent extends AuthEvent {
//   final String email;
//   final String password;
//   final String firstName;
//   final String lastName;
//   // final File? profileImage; // If handling file uploads
//   const SignUpEvent({required this.email, required this.password, required this.firstName, required this.lastName});
//   @override
//   List<Object> get props => [email, password, firstName, lastName];
// }
