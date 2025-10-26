// lib/features/tickets/domain/entities/ticket_entity.dart

class TicketEntity {
  final String id;
  final String eventId;
  final String eventName;
  final String ticketType;
  final String attendeeEmail;
  final String attendeeName;
  final String eventDate;
  final String? scannedAt;
  final String status;
  final String qrCodeData;
  final bool isValid;
  final String? message;
  final bool checkedIn;
  final String? checkedInAt;

  const TicketEntity({
    required this.id,
    required this.eventId,
    required this.eventName,
    required this.ticketType,
    required this.attendeeEmail,
    required this.attendeeName,
    required this.eventDate,
    this.scannedAt,
    required this.status,
    required this.qrCodeData,
    required this.isValid,
    this.message,
    required this.checkedIn,
    this.checkedInAt,
  });
}
