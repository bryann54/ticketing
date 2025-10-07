// lib/features/tickets/data/models/ticket_model.dart

import 'package:json_annotation/json_annotation.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'price')
  final int? price;

  @JsonKey(name: 'number_available')
  final int? numberAvailable;

  @JsonKey(name: 'all_available')
  final int? allAvailable;

  @JsonKey(name: 'booked')
  final bool booked;

  @JsonKey(name: 'reserved')
  final bool reserved;

  @JsonKey(name: 'closed')
  final bool closed;

  @JsonKey(name: 'reserved_at')
  final String? reservedAt;

  @JsonKey(name: 'reserved_until')
  final String? reservedUntil;

  @JsonKey(name: 'ticket_type')
  final int? ticketType;

  @JsonKey(name: 'show')
  final int? showId;

  @JsonKey(name: 'seat')
  final int? seat;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  @JsonKey(name: 'deleted_at')
  final String? deletedAt;

  @JsonKey(name: 'deleted')
  final bool deleted;

  const TicketModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.deleted,
    this.price,
    this.numberAvailable,
    this.allAvailable,
    required this.booked,
    required this.reserved,
    required this.closed,
    this.reservedAt,
    this.reservedUntil,
    this.ticketType,
    this.showId,
    this.seat,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);

  String get status => _determineStatus(booked, reserved, closed);

  static String _determineStatus(bool booked, bool reserved, bool closed) {
    if (closed) return 'closed';
    if (booked) return 'booked';
    if (reserved) return 'reserved';
    return 'available';
  }

  // Convert to entity when needed
  TicketEntity toEntity({
    String eventName = '',
    String attendeeEmail = '',
    String attendeeName = '',
    String eventDate = '',
  }) {
    return TicketEntity(
      id: id.toString(),
      eventId: showId?.toString() ?? '',
      eventName: eventName,
      ticketType: ticketType?.toString() ?? '',
      attendeeEmail: attendeeEmail,
      attendeeName: attendeeName,
      eventDate: eventDate,
      status: status,
      qrCodeData: id.toString(), // Using ticket ID as QR data
    );
  }
}
