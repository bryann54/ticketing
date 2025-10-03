// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'mpesa_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MpesaDetailsModel _$MpesaDetailsModelFromJson(Map<String, dynamic> json) =>
    MpesaDetailsModel(
      consumerKey: json['consumerKey'] as String,
      consumerSecret: json['consumerSecret'] as String,
      shortCode: json['shortCode'] as String,
      passKey: json['passKey'] as String,
      integrationType: json['integrationType'] as String,
      partyB: json['partyB'] as String,
    );

Map<String, dynamic> _$MpesaDetailsModelToJson(MpesaDetailsModel instance) =>
    <String, dynamic>{
      'consumerKey': instance.consumerKey,
      'consumerSecret': instance.consumerSecret,
      'shortCode': instance.shortCode,
      'passKey': instance.passKey,
      'integrationType': instance.integrationType,
      'partyB': instance.partyB,
    };
