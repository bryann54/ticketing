import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticketing/features/venues/data/models/seat_model.dart'; // Import SeatModel

part 'seat_row_model.g.dart';

@JsonSerializable()
class SeatRowModel extends Equatable {
  final int id;
  final String title;
  final List<SeatModel> seats; // List of nested SeatModel

  const SeatRowModel({
    required this.id,
    required this.title,
    required this.seats,
  });

  factory SeatRowModel.fromJson(Map<String, dynamic> json) =>
      _$SeatRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatRowModelToJson(this);

  @override
  List<Object?> get props => [id, title, seats];
}
