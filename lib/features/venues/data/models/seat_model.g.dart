// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) => SeatModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      seatRow: (json['seat_row'] as num).toInt(),
      leftAisle: json['left_aisle'] as bool,
      rightAisle: json['right_aisle'] as bool,
      frontAisle: json['front_aisle'] as bool,
      backAisle: json['back_aisle'] as bool,
    );

Map<String, dynamic> _$SeatModelToJson(SeatModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seat_row': instance.seatRow,
      'left_aisle': instance.leftAisle,
      'right_aisle': instance.rightAisle,
      'front_aisle': instance.frontAisle,
      'back_aisle': instance.backAisle,
    };
