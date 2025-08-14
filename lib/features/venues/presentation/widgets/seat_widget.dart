import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/seat_model.dart';

class SeatWidget extends StatelessWidget {
  final SeatModel seat;
  final bool isSelected;
  final Function(String) onTap;
  final bool isBooked; // Add a booked state

  const SeatWidget({
    super.key,
    required this.seat,
    required this.isSelected,
    required this.onTap,
    this.isBooked = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAisle =
        seat.leftAisle || seat.rightAisle || seat.frontAisle || seat.backAisle;

    // Determine the color and whether the seat is selectable
    Color seatColor;
    Color textColor;
    bool isSelectable = !isBooked;

    if (isBooked) {
      seatColor = Colors.grey.withValues(alpha: 0.5);
      textColor = Colors.white;
    } else if (isSelected) {
      seatColor = theme.colorScheme.primary;
      textColor = theme.colorScheme.onPrimary;
    } else {
      seatColor = isAisle
          ? theme.colorScheme.tertiary
          : theme.colorScheme.surfaceContainerHighest;
      textColor =
          isAisle ? theme.colorScheme.onTertiary : theme.colorScheme.onSurface;
    }

    return GestureDetector(
      onTap: isSelectable ? () => onTap(seat.name) : null,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          seat.name,
          style: theme.textTheme.bodySmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
