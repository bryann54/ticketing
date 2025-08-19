// lib/features/venues/presentation/widgets/seat_row_widget.dart

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
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: seatRow.seats.map((seat) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: SeatWidget(
                  seat: seat,
                  isSelected: selectedSeats.contains(seat.name),
                  onTap: onSeatSelected,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
