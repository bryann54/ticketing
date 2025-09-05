// lib/features/auth/presentation/bloc/auth_state.dart

import 'package:equatable/equatable.dart';
import 'package:ticketing/features/auth/domain/entities/user_entity.dart'; // Import UserEntity

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserEntity? user; // Changed from UserModel? to UserEntity?
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserEntity? user, // Changed from UserModel? to UserEntity?
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage];
}
