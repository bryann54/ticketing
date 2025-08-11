// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatRowModel _$SeatRowModelFromJson(Map<String, dynamic> json) => SeatRowModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      seats: (json['seats'] as List<dynamic>)
          .map((e) => SeatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatRowModelToJson(SeatRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'seats': instance.seats,
    };
