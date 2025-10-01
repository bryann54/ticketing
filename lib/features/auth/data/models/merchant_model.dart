// lib/features/auth/data/models/merchant_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_model.g.dart';

@JsonSerializable()
class MerchantModel extends Equatable {
  final String id;
  final String businessName;
  final String businessEmail;
  final String businessTelephone;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const MerchantModel({
    required this.id,
    required this.businessName,
    required this.businessEmail,
    required this.businessTelephone,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json);

  Map<String, dynamic> toJson() => _$MerchantModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        businessName,
        businessEmail,
        businessTelephone,
        userId,
        createdAt,
        updatedAt,
      ];
}
