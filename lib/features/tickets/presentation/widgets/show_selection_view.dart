// lib/features/tickets/presentation/widgets/show_selection_view.dart

import 'package:flutter/material.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/tickets/presentation/widgets/available_show_card.dart';

class ShowSelectionView extends StatelessWidget {
  final List<ShowModel> availableShows;
  final bool isLoading;
  final String? error;
  final VoidCallback onRetry;

  const ShowSelectionView({
    super.key,
    required this.availableShows,
    required this.isLoading,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.red),
            const SizedBox(height: 8),
            Text(error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (availableShows.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Expanded(
              child: ListView.builder(
                itemCount: availableShows.length,
                itemBuilder: (context, index) {
                  final show = availableShows[index];
                  return AvailableShowCard(show: show);
                },
              ),
            ),
          ],
        ),
      );
    }

    // Default Empty State
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_note, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No upcoming events found.',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Events will appear here once configured on the server.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
