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
import 'package:ticketing/features/tickets/presentation/pages/ticket_scanning_screen.dart';
import 'package:ticketing/features/tickets/presentation/widgets/ticket_result_dialog.dart';
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
  ShowModel? _selectedShow;

  @override
  void initState() {
    super.initState();
    _fetchAvailableShows();
    // Load scanned tickets when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TicketsBloc>().add(const LoadScannedTicketsEvent(''));
    });
  }

  Future<void> _fetchAvailableShows() async {
    setState(() {
      _isShowsLoading = true;
      _showsError = null;
    });

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

  void _startScanning(ShowModel show) {
    setState(() {
      _showScanner = true;
      _selectedShow = show;
    });
  }

  void _stopScanning() {
    setState(() {
      _showScanner = false;
      _selectedShow = null;
    });
    context.read<TicketsBloc>().add(const ResetTicketStateEvent());
  }

  void _viewScanHistory() {
    // Reload scanned tickets when viewing history
    context.read<TicketsBloc>().add(const LoadScannedTicketsEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TicketsBloc, TicketsState>(
      listener: (context, state) {
        _handleStateChanges(state);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        _showScanner ? 'Scanning Ticket' : 'Ticket Check-In',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryColor,
          fontSize: 18,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      leading: _showScanner
          ? IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black87),
              ),
              onPressed: _stopScanning,
            )
          : null,
      actions: _buildAppBarActions(),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_showScanner) return [];

    return [
      IconButton(
        icon: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.refresh, color: Colors.black87, size: 20),
        ),
        onPressed: _fetchAvailableShows,
      ),
    ];
  }

  Widget _buildBody(BuildContext context) {
    if (_showScanner && _selectedShow != null) {
      return TicketScanningScreen(show: _selectedShow!);
    }

    return BlocBuilder<TicketsBloc, TicketsState>(
      builder: (context, state) {
        return _buildHomeView(state);
      },
    );
  }

  Widget _buildHomeView(TicketsState state) {
    // Show history if we have scanned tickets
    if (state.scannedTickets.isNotEmpty) {
      return TicketHistoryView(
        scannedTickets: state.scannedTickets,
       
      );
    }

    // Otherwise show show selection
    return ShowSelectionView(
      availableShows: _availableShows,
      isLoading: _isShowsLoading,
      error: _showsError,
      onRetry: _fetchAvailableShows,
      onShowSelected: _startScanning,
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_showScanner) return null;

    return FloatingActionButton.extended(
      onPressed: _viewScanHistory,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.history, size: 20),
      label: const Text('Scan History'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      elevation: 2,
    );
  }

  void _handleStateChanges(TicketsState state) {
    switch (state.status) {
      case TicketsStatus.scanSuccess:
        _handleScanSuccess(state.currentTicket!);
        break;
      case TicketsStatus.scanError:
        _handleScanError(state.errorMessage);
        break;
      case TicketsStatus.validateSuccess:
        _handleValidateSuccess();
        break;
      default:
        break;
    }
  }

  void _handleScanSuccess(TicketEntity ticket) {
    // Show success dialog
    _showTicketResultDialog(context, ticket);

    // Reload scanned tickets to update history
    context.read<TicketsBloc>().add(const LoadScannedTicketsEvent(''));
  }

  void _handleScanError(String? errorMessage) {
    // Errors are handled in the scanning screen with auto-restart
    // No need for additional handling here
  }

  void _handleValidateSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Ticket validated successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
