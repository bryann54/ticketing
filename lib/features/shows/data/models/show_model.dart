import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_model.g.dart';

@JsonSerializable()
class ShowModel extends Equatable {
  final int? id;
  final bool? deleted;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String name;
  final String? date; // API doc says string($date), so we'll map to String
  final String? time;
  final String? banner;
  @JsonKey(name: 'show_type')
  final String? showType;
  final int? merchant;
  final int? venue;

  const ShowModel({
    this.id,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.name,
    this.date,
    this.time,
    this.banner,
    this.showType,
    this.merchant,
    this.venue,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        deleted,
        createdAt,
        updatedAt,
        deletedAt,
        name,
        date,
        time,
        banner,
        showType,
        merchant,
        venue,
      ];
}
