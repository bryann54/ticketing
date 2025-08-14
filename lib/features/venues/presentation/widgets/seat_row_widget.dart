import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/seat_row_model.dart';
import 'package:ticketing/features/venues/presentation/widgets/seat_widget.dart';

class SeatRowWidget extends StatelessWidget {
  final SeatRowModel seatRow;
  final List<String> selectedSeats;
  final Function(String) onSeatSelected;

  const SeatRowWidget({
    super.key,
    required this.seatRow,
    required this.selectedSeats,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the row title (e.g., 'A')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              seatRow.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 16),
          // Display seats using Wrap for a dynamic layout
          Expanded(
            child: Wrap(
              spacing: 8.0, // horizontal space between seats
              runSpacing: 8.0, // vertical space between rows of seats
              children: seatRow.seats.map((seat) {
                return SeatWidget(
                  seat: seat,
                  isSelected: selectedSeats.contains(seat.name),
                  onTap: onSeatSelected,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
