import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_shows_query_model.g.dart';

@JsonSerializable()
class GetShowsQueryModel extends Equatable {
  final int? venue;
  final String? date;
  @JsonKey(name: 'show_type')
  final String? showType;

  const GetShowsQueryModel({
    this.venue,
    this.date,
    this.showType,
  });

  factory GetShowsQueryModel.fromJson(Map<String, dynamic> json) =>
      _$GetShowsQueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetShowsQueryModelToJson(this);

  @override
  List<Object?> get props => [venue, date, showType];
}
