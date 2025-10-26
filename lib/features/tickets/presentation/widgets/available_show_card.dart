// lib/features/tickets/presentation/widgets/available_show_card.dart

import 'package:flutter/material.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

class AvailableShowCard extends StatelessWidget {
  final ShowModel show;
  final VoidCallback? onTap;

  const AvailableShowCard({
    super.key,
    required this.show,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.event,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          show.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (show.date != null)
              Text(
                _formatShowDateTime(show),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            if (show.showType != null && show.showType!.isNotEmpty)
              Text(
                show.showType!,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.qr_code_scanner,
                size: 16,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                'Scan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatShowDateTime(ShowModel show) {
    final List<String> parts = [];

    if (show.date != null) {
      final date = show.date!;
      parts.add('${date.day}/${date.month}/${date.year}');
    }

    if (show.time != null) {
      final time = show.time!;
      parts.add(
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}');
    }

    return parts.join(' • ');
  }
}
