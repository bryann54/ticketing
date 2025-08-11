import 'package:equatable/equatable.dart';
import 'package:ticketing/features/shows/domain/usecases/get_shows_usecase.dart';

sealed class ShowsEvent extends Equatable {
  const ShowsEvent();
}

final class GetShowsEvent extends ShowsEvent {
  final GetShowsParams params;

  const GetShowsEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
