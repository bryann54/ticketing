import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/features/venues/data/models/seat_row_model.dart';
import 'package:ticketing/features/venues/data/models/venue_model.dart';

@RoutePage()
class SeatLayoutScreen extends StatelessWidget {
  final VenueModel venue;
  const SeatLayoutScreen({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${venue.abbreviation} Seat Layout'),
      ),
      body: SeatMapSectionView(venue: venue),
      bottomNavigationBar: _buildConfirmButton(theme),
    );
  }

  Widget _buildConfirmButton(ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            // Logic to confirm selection and proceed
          },
          child: Text(
            'Proceed',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Separate SeatMapSectionView widget for better separation of concerns
class SeatMapSectionView extends StatelessWidget {
  final VenueModel venue;

  const SeatMapSectionView({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Group rows by sections
    final mainFloorRows = venue.seatRows
        .where((row) => ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K']
            .contains(row.title))
        .toList();

    final lowerLevelRows = venue.seatRows
        .where((row) => ['L', 'M', 'N'].contains(row.title))
        .toList();

    final balconyRows = venue.seatRows
        .where((row) => ['O', 'P', 'Q', 'R'].contains(row.title))
        .toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildStage(theme),
            const SizedBox(height: 24), // Increased spacing for clarity

            // Main Floor
            _buildSectionHeader(theme, 'MAIN FLOOR'),
            const SizedBox(height: 8),
            _buildMainFloorSeating(context, theme, mainFloorRows),
            const SizedBox(height: 24),

            // Lower Level (Orchestra)
            if (lowerLevelRows.isNotEmpty) ...[
              _buildSectionHeader(theme, 'ORCHESTRA'),
              const SizedBox(height: 8),
              _buildSymmetricalSeating(context, theme, lowerLevelRows,
                  'Orchestra Left', 'Orchestra Right'),
              const SizedBox(height: 24),
            ],

            // Balcony
            if (balconyRows.isNotEmpty) ...[
              _buildSectionHeader(theme, 'BALCONY'),
              const SizedBox(height: 8),
              _buildSymmetricalSeating(
                  context, theme, balconyRows, 'Balcony Left', 'Balcony Right'),
              const SizedBox(height: 24),
            ],

            // Padding at the bottom
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStage(ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.8),
            theme.colorScheme.primary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'STAGE',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
      ),
    );
  }

  Widget _buildMainFloorSeating(
      BuildContext context, ThemeData theme, List<SeatRowModel> rows) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left section
            Expanded(
              flex: 3,
              child: _buildSectionCard(
                context,
                theme,
                'Front Left',
                _getRowsForSection(rows, 'left_front'),
                color: theme.colorScheme.tertiaryContainer,
                onColor: theme.colorScheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(width: 8),

            // Center sections
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  _buildSectionCard(
                    context,
                    theme,
                    'Center Front',
                    _getRowsForSection(rows, 'center_front'),
                    color: theme.colorScheme.primaryContainer,
                    onColor: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 8),
                  _buildSectionCard(
                    context,
                    theme,
                    'Center',
                    _getRowsForSection(rows, 'center'),
                    color: theme.colorScheme.primaryContainer,
                    onColor: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(height: 8),
                  _buildSectionCard(
                    context,
                    theme,
                    'Center Back',
                    _getRowsForSection(rows, 'center_back'),
                    color: theme.colorScheme.primaryContainer,
                    onColor: theme.colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Right section
            Expanded(
              flex: 3,
              child: _buildSectionCard(
                context,
                theme,
                'Front Right',
                _getRowsForSection(rows, 'right_front'),
                color: theme.colorScheme.tertiaryContainer,
                onColor: theme.colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSymmetricalSeating(BuildContext context, ThemeData theme,
      List<SeatRowModel> rows, String leftTitle, String rightTitle) {
    return Row(
      children: [
        Expanded(
          child: _buildSectionCard(
            context,
            theme,
            leftTitle,
            rows.take(rows.length ~/ 2).toList(),
            color: theme.colorScheme.secondaryContainer,
            onColor: theme.colorScheme.onSecondaryContainer,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildSectionCard(
            context,
            theme,
            rightTitle,
            rows.skip(rows.length ~/ 2).toList(),
            color: theme.colorScheme.secondaryContainer,
            onColor: theme.colorScheme.onSecondaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    ThemeData theme,
    String title,
    List<SeatRowModel> seatRows, {
    required Color color,
    required Color onColor,
  }) {
    final seatCount =
        seatRows.fold<int>(0, (sum, row) => sum + row.seats.length);
    final isAvailable = seatCount > 0;

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: isAvailable
            ? () {
                context.router.push(SeatSelectionRoute(
                  title: title,
                  seatRows: seatRows,
                ));
              }
            : null,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isAvailable ? 1.0 : 0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: onColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: onColor.withValues(alpha: isAvailable ? 1.0 : 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                isAvailable ? '$seatCount seats' : 'Sold out',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: onColor.withValues(alpha: isAvailable ? 0.8 : 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<SeatRowModel> _getRowsForSection(
      List<SeatRowModel> allRows, String section) {
    switch (section) {
      case 'left_front':
        return allRows
            .where((row) => ['A', 'B', 'C'].contains(row.title))
            .toList();
      case 'center_front':
        return allRows.where((row) => ['D', 'E'].contains(row.title)).toList();
      case 'center':
        return allRows
            .where((row) => ['F', 'G', 'H'].contains(row.title))
            .toList();
      case 'center_back':
        return allRows
            .where((row) => ['I', 'J', 'K'].contains(row.title))
            .toList();
      case 'right_front':
        return allRows
            .where((row) => ['A', 'B', 'C'].contains(row.title))
            .toList();
      default:
        return allRows;
    }
  }
}
