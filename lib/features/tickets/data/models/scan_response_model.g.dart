// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketTypeModel _$TicketTypeModelFromJson(Map<String, dynamic> json) =>
    TicketTypeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      banner: json['banner'] as String?,
      merchant: (json['merchant'] as num).toInt(),
      show: (json['show'] as num).toInt(),
    );

Map<String, dynamic> _$TicketTypeModelToJson(TicketTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'banner': instance.banner,
      'merchant': instance.merchant,
      'show': instance.show,
    };

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) => SeatModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      seat_row: (json['seat_row'] as num).toInt(),
    );

Map<String, dynamic> _$SeatModelToJson(SeatModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'seat_row': instance.seat_row,
    };

ScannedShowModel _$ScannedShowModelFromJson(Map<String, dynamic> json) =>
    ScannedShowModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      date: json['date'] as String,
      time: json['time'] as String?,
      banner: json['banner'] as String?,
      show_type: json['show_type'] as String,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$ScannedShowModelToJson(ScannedShowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'time': instance.time,
      'banner': instance.banner,
      'show_type': instance.show_type,
      'slug': instance.slug,
    };

TicketDetailModel _$TicketDetailModelFromJson(Map<String, dynamic> json) =>
    TicketDetailModel(
      id: (json['id'] as num).toInt(),
      ticket_type:
          TicketTypeModel.fromJson(json['ticket_type'] as Map<String, dynamic>),
      show: ScannedShowModel.fromJson(json['show'] as Map<String, dynamic>),
      seat: json['seat'] == null
          ? null
          : SeatModel.fromJson(json['seat'] as Map<String, dynamic>),
      price: (json['price'] as num).toInt(),
      booked: json['booked'] as bool,
      reserved: json['reserved'] as bool,
      closed: json['closed'] as bool,
    );

Map<String, dynamic> _$TicketDetailModelToJson(TicketDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_type': instance.ticket_type,
      'show': instance.show,
      'seat': instance.seat,
      'price': instance.price,
      'booked': instance.booked,
      'reserved': instance.reserved,
      'closed': instance.closed,
    };

ScanResponseModel _$ScanResponseModelFromJson(Map<String, dynamic> json) =>
    ScanResponseModel(
      id: (json['id'] as num).toInt(),
      ticket:
          TicketDetailModel.fromJson(json['ticket'] as Map<String, dynamic>),
      show: ScannedShowModel.fromJson(json['show'] as Map<String, dynamic>),
      number_of_tickets: (json['number_of_tickets'] as num).toInt(),
      phone_number: json['phone_number'] as String,
      email: json['email'] as String,
      payment_status: json['payment_status'] as String,
      payment_id: json['payment_id'] as String,
      checked_in: json['checked_in'] as bool,
      amount: json['amount'] as String?,
    );

Map<String, dynamic> _$ScanResponseModelToJson(ScanResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket': instance.ticket,
      'show': instance.show,
      'number_of_tickets': instance.number_of_tickets,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'payment_status': instance.payment_status,
      'payment_id': instance.payment_id,
      'checked_in': instance.checked_in,
      'amount': instance.amount,
    };
