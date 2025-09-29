import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/home/presentation/bloc/home_state.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_bloc.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_event.dart';
import 'package:ticketing/features/venues/presentation/bloc/venues_state.dart';
import 'package:ticketing/features/venues/presentation/widgets/venue_list_view.dart';
import 'package:ticketing/features/venues/presentation/widgets/error_widget.dart';
import 'package:ticketing/features/venues/presentation/widgets/loading_widget.dart';

@RoutePage()
@injectable
class VenuesScreen extends StatefulWidget {
  const VenuesScreen({super.key});

  @override
  State<VenuesScreen> createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VenuesBloc>().add(GetVenuesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Venues', style: theme.textTheme.titleLarge),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<VenuesBloc>().add(GetVenuesEvent());
        },
        child: BlocBuilder<VenuesBloc, VenuesState>(
          builder: (context, state) {
            if (state is VenuesLoading) {
              return const LoadingWidget(message: 'Loading venues...');
            } else if (state is VenuesLoaded) {
              return VenueListView(venues: state.venues);
            } else if (state is VenuesError) {
              return CustomErrorWidget(
                failure: state.failure,
                onRetry: () => context.read<VenuesBloc>().add(GetVenuesEvent()),
              );
            }
            return const Center(child: Text('Please refresh to load venues.'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('create venue'),
        icon: const Icon(Icons.add),
        onPressed: () {
          final state = context.read<HomeBloc>().state;
          if (state is HomeLoaded) {
            AutoRouter.of(context).push(AddShowRoute(venues: state.venues));
          }
        },
      ),
    );
  }
}
