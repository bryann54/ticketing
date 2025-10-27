// lib/features/tickets/data/models/scan_response_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'scan_response_model.g.dart';

@JsonSerializable()
class TicketTypeModel {
  final int id;
  final String name;
  final String? banner;
  final int merchant;
  final int show;

  TicketTypeModel({
    required this.id,
    required this.name,
    this.banner,
    required this.merchant,
    required this.show,
  });

  factory TicketTypeModel.fromJson(Map<String, dynamic> json) =>
      _$TicketTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketTypeModelToJson(this);
}

@JsonSerializable()
class SeatModel {
  final int id;
  final String name;
  final int seat_row;

  SeatModel({
    required this.id,
    required this.name,
    required this.seat_row,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
  Map<String, dynamic> toJson() => _$SeatModelToJson(this);
}

// Renamed from ShowModel to ScannedShowModel
@JsonSerializable()
class ScannedShowModel {
  final int id;
  final String name;
  final String date;
  final String? time;
  final String? banner;
  final String show_type;
  final String slug;

  ScannedShowModel({
    required this.id,
    required this.name,
    required this.date,
    this.time,
    this.banner,
    required this.show_type,
    required this.slug,
  });

  factory ScannedShowModel.fromJson(Map<String, dynamic> json) =>
      _$ScannedShowModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScannedShowModelToJson(this);
}

@JsonSerializable()
class TicketDetailModel {
  final int id;
  final TicketTypeModel ticket_type;
  final ScannedShowModel show; // Updated reference
  final SeatModel? seat;
  final int price;
  final bool booked;
  final bool reserved;
  final bool closed;

  TicketDetailModel({
    required this.id,
    required this.ticket_type,
    required this.show,
    this.seat,
    required this.price,
    required this.booked,
    required this.reserved,
    required this.closed,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketDetailModelToJson(this);
}

@JsonSerializable()
class ScanResponseModel {
  final int id;
  final TicketDetailModel ticket;
  final ScannedShowModel show; // Updated reference
  final int number_of_tickets;
  final String phone_number;
  final String email;
  final String payment_status;
  final String payment_id;
  final bool checked_in;
  final String? amount;

  ScanResponseModel({
    required this.id,
    required this.ticket,
    required this.show,
    required this.number_of_tickets,
    required this.phone_number,
    required this.email,
    required this.payment_status,
    required this.payment_id,
    required this.checked_in,
    this.amount,
  });

  factory ScanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ScanResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ScanResponseModelToJson(this);
}
