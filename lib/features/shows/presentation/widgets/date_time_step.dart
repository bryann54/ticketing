import 'package:flutter/material.dart';
import 'package:ticketing/features/shows/presentation/widgets/date_time_tile.dart';

class DateTimeStep extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;

  const DateTimeStep({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onSelectDate,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).dividerColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              DateTimeTile(
                icon: Icons.calendar_today,
                title: 'Date',
                subtitle:
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                onTap: onSelectDate,
                isFirst: true,
              ),
              Divider(
                height: 1,
                color: Theme.of(context).dividerColor,
                indent: 56,
              ),
              DateTimeTile(
                icon: Icons.access_time,
                title: 'Time',
                subtitle: selectedTime.format(context),
                onTap: onSelectTime,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
