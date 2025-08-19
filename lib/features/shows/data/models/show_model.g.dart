// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowModel _$ShowModelFromJson(Map<String, dynamic> json) => ShowModel(
      id: (json['id'] as num?)?.toInt(),
      deleted: json['deleted'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      name: json['name'] as String,
      date: ShowModel._dateFromJson(json['date'] as String?),
      time: ShowModel._timeFromJson(json['time'] as String?),
      banner: json['banner'] as String?,
      showType: json['show_type'] as String?,
      merchant: (json['merchant'] as num?)?.toInt(),
      venue: (json['venue'] as num?)?.toInt(),
      tickets: json['tickets'] as List<dynamic>?,
    );

Map<String, dynamic> _$ShowModelToJson(ShowModel instance) => <String, dynamic>{
      'id': instance.id,
      'deleted': instance.deleted,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'name': instance.name,
      'date': ShowModel._dateToJson(instance.date),
      'time': ShowModel._timeToJson(instance.time),
      'banner': instance.banner,
      'show_type': instance.showType,
      'merchant': instance.merchant,
      'venue': instance.venue,
      'tickets': instance.tickets,
    };
