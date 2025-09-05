// lib/features/auth/data/models/user_model.dart

import 'package:ticketing/features/auth/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart'; // Ensure you run build_runner for this

@JsonSerializable()
class UserModel extends Equatable {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? profileImageUrl;

  const UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  // Convert UserModel to UserEntity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      profileImageUrl: profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [id, email, firstName, lastName, profileImageUrl];
}
