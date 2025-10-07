// lib/features/tickets/presentation/pages/tickets_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/common/res/colors.dart';
import 'package:ticketing/core/di/injector.dart';
import 'package:ticketing/features/shows/data/models/get_shows_query_model.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';
import 'package:ticketing/features/shows/domain/repositories/shows_repository.dart';
import 'package:ticketing/features/tickets/domain/entities/ticket_entity.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_bloc.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_event.dart';
import 'package:ticketing/features/tickets/presentation/bloc/tickets_state.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_scanner.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_result_dialog.dart';

// Import the new widgets
import 'package:ticketing/features/tickets/presentation/widgets/show_selection_view.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_history_view.dart';

@RoutePage()
class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  final _showsRepository = getIt<ShowsRepository>();

  bool _showScanner = false;
  List<ShowModel> _availableShows = [];
  bool _isShowsLoading = true;
  String? _showsError;
  ShowModel? _selectedShow; // Track the selected show

  @override
  void initState() {
    super.initState();
    _fetchAvailableShows();
  }

  Future<void> _fetchAvailableShows() async {
    setState(() {
      _isShowsLoading = true;
      _showsError = null;
    });

    // Using default/empty query to fetch all shows
    final defaultQuery = GetShowsQueryModel();
    final result = await _showsRepository.getShows(defaultQuery);

    result.fold(
      (failure) {
        setState(() {
          _isShowsLoading = false;
          _showsError = 'Failed to load available shows.';
        });
      },
      (shows) {
        setState(() {
          _isShowsLoading = false;
          _availableShows = shows;
        });
      },
    );
  }


  void _stopScanning() {
    setState(() {
      _showScanner = false;
      _selectedShow = null;
    });
    context.read<TicketsBloc>().add(const ResetTicketStateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showScanner ? 'Scan Ticket' : 'Tickets Check',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        leading: _showScanner
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _stopScanning,
              )
            : null,
      ),
      body: BlocListener<TicketsBloc, TicketsState>(
        listener: (context, state) {
          if (state.status == TicketsStatus.scanSuccess) {
            setState(() {
              _showScanner = false;
            });
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
        child: BlocBuilder<TicketsBloc, TicketsState>(
          builder: (context, state) {
            if (_showScanner && _selectedShow != null) {
              return TicketScanner(showId: _selectedShow!.id?.toString() ?? '');
            }

            return _buildHomeView(state);
          },
        ),
      ),
    );
  }

  // Refactored to use extracted widgets
  Widget _buildHomeView(TicketsState state) {
    // 1. If history is loaded, show history
    if (state.scannedTickets.isNotEmpty &&
        state.status != TicketsStatus.initial) {
      return TicketHistoryView(scannedTickets: state.scannedTickets);
    }

    // 2. Otherwise, show the list of available shows (the "home" view)
    return ShowSelectionView(
      availableShows: _availableShows,
      isLoading: _isShowsLoading,
      error: _showsError,
      onRetry: _fetchAvailableShows,
     
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
