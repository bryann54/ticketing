// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) =>
    MerchantModel(
      id: json['id'] as String,
      name: json['name'] as String,
      businessEmail: json['businessEmail'] as String?,
      businessTelephone: json['businessTelephone'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$MerchantModelToJson(MerchantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'businessEmail': instance.businessEmail,
      'businessTelephone': instance.businessTelephone,
      'image': instance.image,
    };
