// lib/features/tickets/presentation/widgets/ticket_result_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_event.dart';

class TicketResultDialog extends StatelessWidget {
  final TicketEntity ticket;

  const TicketResultDialog({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildTicketInfo(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isSuccess = ticket.isValid && ticket.isPaymentCompleted;

    return Row(
      children: [
        Icon(
          isSuccess ? Icons.check_circle : Icons.error,
          color: isSuccess ? Colors.green : Colors.orange,
          size: 32,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSuccess ? 'Valid Ticket' : 'Ticket Issue',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isSuccess ? 'Ready for entry' : 'Please review ticket details',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTicketInfo() {
    return Column(
      children: [
        _buildInfoRow('Event', ticket.eventName),
        _buildInfoRow('Ticket Type', ticket.ticketTypeName),
        if (ticket.attendeeName.isNotEmpty)
          _buildInfoRow('Attendee', ticket.attendeeName),
        if (ticket.attendeePhone.isNotEmpty)
          _buildInfoRow('Phone', ticket.attendeePhone),
        if (ticket.attendeeEmail.isNotEmpty)
          _buildInfoRow('Email', ticket.attendeeEmail),
        if (ticket.seatName != null)
          _buildInfoRow('Seat', '${ticket.seatName} (Row ${ticket.seatRow})'),
        if (ticket.price != null) _buildInfoRow('Price', '\$${ticket.price}'),
        _buildInfoRow('Status', _formatStatus(ticket.status)),
        _buildInfoRow('Payment', _formatPaymentStatus(ticket.paymentStatus)),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Scan Another'),
          ),
        ),
        const SizedBox(width: 12),
        if (ticket.isValid && !ticket.checkedIn)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Reserve ticket logic
                context.read<TicketsBloc>().add(ReserveTicketEvent(ticket.id));
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: const Text('Reserve Ticket'),
            ),
          ),
      ],
    );
  }

  String _formatStatus(String status) {
    return status.toUpperCase();
  }

  String _formatPaymentStatus(String status) {
    return status.toUpperCase();
  }
}
