// lib/features/tickets/presentation/pages/show_details_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_event.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_state.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_result_dialog.dart';

@RoutePage()
class ShowDetailsScreen extends StatefulWidget {
  final ShowModel show;

  const ShowDetailsScreen({
    super.key,
    required this.show,
  });

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<TicketsBloc, TicketsState>(
        listener: (context, state) {
          if (state.status == TicketsStatus.scanSuccess) {
            _showTicketResultDialog(context, state.currentTicket!);
          } else if (state.status == TicketsStatus.scanError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Scan failed'),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    context
                        .read<TicketsBloc>()
                        .add(const ResetTicketStateEvent());
                  },
                ),
              ),
            );
          }
        },
        child: _buildShowDetailsView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the new scanning screen
          context.pushRoute(TicketScanningRoute(show: widget.show));
        },
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Scan Ticket'),
      ),
    );
  }

  Widget _buildShowDetailsView() {
    final dateString =
        widget.show.date?.toLocal().toString().split(' ')[0] ?? 'Date N/A';
    final timeString = widget.show.time != null
        ? '${widget.show.time!.hour.toString().padLeft(2, '0')}:${widget.show.time!.minute.toString().padLeft(2, '0')}'
        : 'Time N/A';

    return CustomScrollView(
      slivers: [
        // Minimalist header
        SliverAppBar(
          expandedHeight: 180,
          pinned: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
            onPressed: () => context.router.maybePop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.show.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                shadows: [
                  Shadow(
                    color: Colors.black54,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            background: Hero(
              tag:
                  'show_banner_${widget.show.id ?? widget.show.name}_${widget.show.hashCode}',
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (widget.show.banner != null &&
                      widget.show.banner!.isNotEmpty)
                    Image.network(
                      widget.show.banner!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.theaters,
                          size: 48,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withOpacity(0.3),
                        ),
                      ),
                    )
                  else
                    Container(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Icon(
                        Icons.theaters,
                        size: 48,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withOpacity(0.3),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSimpleInfo(
                        context,
                        icon: Icons.calendar_today_rounded,
                        value: dateString,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildSimpleInfo(
                        context,
                        icon: Icons.access_time_rounded,
                        value: timeString,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                Text(
                  'Statistics',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildMinimalStat(
                        context,
                        label: 'Scanned',
                        value: '0',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildMinimalStat(
                        context,
                        label: 'Total',
                        value: '0',
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Recent scans
                Text(
                  'Recent Scans',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),

                // Simple empty state
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          size: 40,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.2),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No scans yet',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.4),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 80), // Space for FAB
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleInfo(
    BuildContext context, {
    required IconData icon,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalStat(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }

  void _showTicketResultDialog(BuildContext context, TicketEntity ticket) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => TicketResultDialog(ticket: ticket),
    );
  }
}
