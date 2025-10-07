// lib/features/tickets/presentation/widgets/ticket_result_dialog.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';

class TicketResultDialog extends StatelessWidget {
  final TicketEntity ticket;

  const TicketResultDialog({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    // Determine status based on your new status logic
    final isSuccess = _isTicketValid(ticket.status);
    final isBooked = ticket.status.toLowerCase() == 'booked';
    final isReserved = ticket.status.toLowerCase() == 'reserved';
    final isClosed = ticket.status.toLowerCase() == 'closed';

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            _getStatusIcon(ticket.status),
            color: _getStatusColor(ticket.status),
          ),
          const SizedBox(width: 8),
          Text(_getStatusTitle(ticket.status)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ticket.eventName.isNotEmpty)
            _buildInfoRow('Event', ticket.eventName),
          if (ticket.attendeeName.isNotEmpty)
            _buildInfoRow('Attendee', ticket.attendeeName),
          if (ticket.attendeeEmail.isNotEmpty)
            _buildInfoRow('Email', ticket.attendeeEmail),
          if (ticket.ticketType.isNotEmpty)
            _buildInfoRow('Ticket Type', ticket.ticketType),
          _buildInfoRow('Status', _formatStatus(ticket.status)),
          _buildInfoRow('Ticket ID', ticket.id),
          if (ticket.scannedAt != null)
            _buildInfoRow(
              'Scanned At',
              ticket.scannedAt!,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
        if (isSuccess)
          ElevatedButton(
            onPressed: () {
              // Mark ticket as used/validated
              // context.read<TicketsBloc>().add(ValidateTicketEvent(ticket.id));
              Navigator.of(context).pop();
            },
            child: const Text('Validate Ticket'),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value.isNotEmpty ? value : 'Not available'),
          ),
        ],
      ),
    );
  }

  bool _isTicketValid(String status) {
    final lowerStatus = status.toLowerCase();
    // Define what you consider a "valid" ticket status
    return lowerStatus == 'booked' || lowerStatus == 'reserved';
  }

  IconData _getStatusIcon(String status) {
    final lowerStatus = status.toLowerCase();
    switch (lowerStatus) {
      case 'booked':
        return Icons.check_circle;
      case 'reserved':
        return Icons.schedule;
      case 'closed':
        return Icons.block;
      default: // available or other
        return Icons.error;
    }
  }

  Color _getStatusColor(String status) {
    final lowerStatus = status.toLowerCase();
    switch (lowerStatus) {
      case 'booked':
        return Colors.green;
      case 'reserved':
        return Colors.orange;
      case 'closed':
        return Colors.red;
      default: // available or other
        return Colors.grey;
    }
  }

  String _getStatusTitle(String status) {
    final lowerStatus = status.toLowerCase();
    switch (lowerStatus) {
      case 'booked':
        return 'Ticket Booked';
      case 'reserved':
        return 'Ticket Reserved';
      case 'closed':
        return 'Ticket Closed';
      case 'available':
        return 'Ticket Available';
      default:
        return 'Ticket Status';
    }
  }

  String _formatStatus(String status) {
    return status.toUpperCase();
  }
}
