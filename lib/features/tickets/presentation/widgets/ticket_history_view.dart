// lib/features/tickets/presentation/widgets/ticket_history_view.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';

class TicketHistoryView extends StatelessWidget {
  final List<TicketEntity> scannedTickets;

  const TicketHistoryView({
    super.key,
    required this.scannedTickets,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
        return Colors.green;
      case 'used':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'valid':
        return Icons.check_circle;
      case 'used':
        return Icons.history;
      case 'expired':
        return Icons.error;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: scannedTickets.length,
      itemBuilder: (context, index) {
        final ticket = scannedTickets[index];
        final statusColor = _getStatusColor(ticket.status);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getStatusIcon(ticket.status),
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(
              ticket.attendeeName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ticket.eventName),
                Text(
                  ticket.attendeeEmail,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Chip(
              label: Text(
                ticket.status.toUpperCase(),
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
              backgroundColor: statusColor,
            ),
          ),
        );
      },
    );
  }
}
