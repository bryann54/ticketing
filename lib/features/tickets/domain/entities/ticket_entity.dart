// lib/features/tickets/domain/entities/ticket_entity.dart
class TicketEntity {
  final String id;
  final String eventId;
  final String eventName;
  final String ticketType;
  final String ticketTypeName;
  final String attendeeEmail;
  final String attendeeName;
  final String attendeePhone;
  final String eventDate;
  final String? scannedAt;
  final String status;
  final String qrCodeData;
  final bool isValid;
  final String? message;
  final bool checkedIn;
  final String? checkedInAt;
  final int? price;
  final String? seatName;
  final int? seatRow;
  final String paymentStatus;
  final String paymentId;

  const TicketEntity({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.ticketType,
    required this.ticketTypeName,
    required this.attendeeEmail,
    required this.attendeeName,
    required this.attendeePhone,
    required this.eventDate,
    this.scannedAt,
    required this.status,
    required this.qrCodeData,
    required this.isValid,
    this.message,
    required this.checkedIn,
    this.checkedInAt,
    this.price,
    this.seatName,
    this.seatRow,
    required this.paymentStatus,
    required this.paymentId,
  });

  bool get isBooked => status == 'booked';
  bool get isReserved => status == 'reserved';
  bool get isClosed => status == 'closed';
  bool get isPaymentCompleted => paymentStatus == 'completed';
}
