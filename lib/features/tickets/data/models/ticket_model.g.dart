// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: (json['id'] as num).toInt(),
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
      deleted: json['deleted'] as bool,
      price: (json['price'] as num?)?.toInt(),
      numberAvailable: (json['number_available'] as num?)?.toInt(),
      allAvailable: (json['all_available'] as num?)?.toInt(),
      booked: json['booked'] as bool,
      reserved: json['reserved'] as bool,
      closed: json['closed'] as bool,
      reservedAt: json['reserved_at'] as String?,
      reservedUntil: json['reserved_until'] as String?,
      ticketType: (json['ticket_type'] as num?)?.toInt(),
      showId: (json['show'] as num?)?.toInt(),
      seat: (json['seat'] as num?)?.toInt(),
      valid: json['valid'] as bool?,
      message: json['message'] as String?,
      checkedIn: json['checked_in'] as bool?,
      checkedInAt: json['checked_in_at'] as String?,
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'number_available': instance.numberAvailable,
      'all_available': instance.allAvailable,
      'booked': instance.booked,
      'reserved': instance.reserved,
      'closed': instance.closed,
      'reserved_at': instance.reservedAt,
      'reserved_until': instance.reservedUntil,
      'ticket_type': instance.ticketType,
      'show': instance.showId,
      'seat': instance.seat,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'deleted': instance.deleted,
      'valid': instance.valid,
      'message': instance.message,
      'checked_in': instance.checkedIn,
      'checked_in_at': instance.checkedInAt,
    };
