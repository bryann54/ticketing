import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/features/venues/data/models/seat_row_model.dart';
import 'package:ticketing/features/venues/presentation/widgets/seat_row_widget.dart';

@RoutePage()
class SeatSelectionScreen extends StatefulWidget {
  final String title;
  final List<SeatRowModel> seatRows;

  const SeatSelectionScreen({
    super.key,
    required this.title,
    required this.seatRows,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final List<String> _selectedSeats = [];

  void _toggleSeatSelection(String seatName) {
    setState(() {
      if (_selectedSeats.contains(seatName)) {
        _selectedSeats.remove(seatName);
      } else {
        _selectedSeats.add(seatName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: widget.seatRows.map((seatRow) {
            return SeatRowWidget(
              seatRow: seatRow,
              selectedSeats: _selectedSeats,
              onSeatSelected: _toggleSeatSelection,
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _selectedSeats.isEmpty
                ? null
                : () {
                    // Handle saving seats for this section, then pop back
                    context.router.maybePop(_selectedSeats);
                  },
            child: Text('Confirm Seats (${_selectedSeats.length})'),
          ),
        ),
      ),
    );
  }
}
