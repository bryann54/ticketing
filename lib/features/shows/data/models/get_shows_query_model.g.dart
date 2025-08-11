// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shows_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShowsQueryModel _$GetShowsQueryModelFromJson(Map<String, dynamic> json) =>
    GetShowsQueryModel(
      venue: (json['venue'] as num?)?.toInt(),
      date: json['date'] as String?,
      showType: json['show_type'] as String?,
    );

Map<String, dynamic> _$GetShowsQueryModelToJson(GetShowsQueryModel instance) =>
    <String, dynamic>{
      'venue': instance.venue,
      'date': instance.date,
      'show_type': instance.showType,
    };
