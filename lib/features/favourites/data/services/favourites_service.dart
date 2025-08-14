import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

@lazySingleton
class FavouritesService {
  static const _showsKey = 'favourite_show_ids';
  static const _venuesKey = 'favourite_venue_ids';

  Future<Either<Failure, List<int>>> getFavouriteShowIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> showIds = prefs.getStringList(_showsKey) ?? [];
      return Right(showIds.map(int.parse).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<int>>> getFavouriteVenueIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> venueIds = prefs.getStringList(_venuesKey) ?? [];
      return Right(venueIds.map(int.parse).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, void>> saveFavouriteShowIds(List<int> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          _showsKey, ids.map((id) => id.toString()).toList());
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, void>> saveFavouriteVenueIds(List<int> ids) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          _venuesKey, ids.map((id) => id.toString()).toList());
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
