// lib/features/merchant/data/models/mpesa_details_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'mpesa_details_model.g.dart';

@JsonSerializable()
class MpesaDetailsModel {
  final String consumerKey;
  final String consumerSecret;
  final String shortCode;
  final String passKey;
  final String integrationType;
  final String partyB;

  MpesaDetailsModel({
    required this.consumerKey,
    required this.consumerSecret,
    required this.shortCode,
    required this.passKey,
    required this.integrationType,
    required this.partyB,
  });

  Map<String, dynamic> toJson() {
    return {
      'consumer_key': consumerKey,
      'consumer_secret': consumerSecret,
      'shortcode': shortCode,
      'pass_key': passKey,
      'integration_type': integrationType,
      'party_b': partyB,
    };
  }

  factory MpesaDetailsModel.fromJson(Map<String, dynamic> json) {
    return MpesaDetailsModel(
      consumerKey: json['consumer_key'] ?? '',
      consumerSecret: json['consumer_secret'] ?? '',
      shortCode: json['shortcode'] ?? '',
      passKey: json['pass_key'] ?? '',
      integrationType: json['integration_type'] ?? '',
      partyB: json['party_b'] ?? '',
    );
  }
}
