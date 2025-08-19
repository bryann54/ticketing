// lib/features/home/presentation/screens/home_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ticketing/common/helpers/app_router.gr.dart';
import 'package:ticketing/features/home/presentation/bloc/home_bloc.dart';
import 'package:ticketing/features/home/presentation/bloc/home_event.dart';
import 'package:ticketing/features/home/presentation/bloc/home_state.dart';
import 'package:ticketing/features/home/presentation/widgets/home_app_bar.dart';
import 'package:ticketing/features/home/presentation/widgets/home_error_state.dart';
import 'package:ticketing/features/home/presentation/widgets/home_loaded_state.dart';
import 'package:ticketing/features/home/presentation/widgets/home_loading_state.dart';
import 'package:ticketing/features/home/presentation/widgets/home_initial_state.dart';

@RoutePage()
@injectable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const LoadHomeData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const HomeShimmerLoadingState();
          } else if (state is HomeLoaded) {
            return HomeLoadedState(shows: state.shows, venues: state.venues);
          } else if (state is HomeError) {
            return HomeErrorState(failure: state.failure);
          }
          return const HomeInitialState();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('create Event'),
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
