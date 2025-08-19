import 'package:flutter/material.dart';

class ShowTypeDropdown extends StatelessWidget {
  final String? selectedShowType;
  final ValueChanged<String?> onChanged;

  const ShowTypeDropdown({
    super.key,
    required this.selectedShowType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Show Type',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedShowType,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.category,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          items: const [
            DropdownMenuItem(
              value: 'ON_VENUE',
              child: Text('On Venue'),
            ),
            DropdownMenuItem(
              value: 'OFF_VENUE',
              child: Text('Off Venue'),
            ),
          ],
          onChanged: onChanged,
          validator: (value) => value == null ? 'Show type is required' : null,
        ),
      ],
    );
  }
}
