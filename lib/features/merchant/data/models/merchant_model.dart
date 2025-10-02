// lib/features/auth/data/models/merchant_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'merchant_model.g.dart';
@JsonSerializable()
class MerchantModel extends Equatable {
  final String id;
  final String name; 
  final String? businessEmail; 
  final String? businessTelephone; 
  final String? image;

  const MerchantModel({
    required this.id,
    required this.name,
    this.businessEmail,
    this.businessTelephone,
    this.image,
  });

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'] as Map<String, dynamic>? ?? json;

    return MerchantModel(
      id: payload['id']?.toString() ?? '0',
      name: payload['name'] as String? ?? '',
      businessEmail:
          payload['email'] as String?, 
      businessTelephone: payload['phone_number']
          as String?,
      image: payload['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': businessEmail, 
        'phone_number': businessTelephone,
        'image': image,
      };

  @override
  List<Object?> get props =>
      [id, name, businessEmail, businessTelephone, image];
}
