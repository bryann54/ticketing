import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_event.dart';
import 'package:ticketing/features/favourites/presentation/bloc/favourites_state.dart';
import 'package:ticketing/features/shows/data/models/show_model.dart';

class ShowCard extends StatelessWidget {
  final ShowModel show;

  const ShowCard({super.key, required this.show});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(show.name),
        trailing: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoaded) {
              final isFavourite = state.favouriteShowIds.contains(show.id);
              return IconButton(
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context
                      .read<FavouritesBloc>()
                      .add(ToggleFavouriteShow(show.id!));
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
