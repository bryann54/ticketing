import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_model.g.dart';

@JsonSerializable()
class SeatModel extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'seat_row')
  final int seatRow;
  @JsonKey(name: 'left_aisle')
  final bool leftAisle;
  @JsonKey(name: 'right_aisle')
  final bool rightAisle;
  @JsonKey(name: 'front_aisle')
  final bool frontAisle;
  @JsonKey(name: 'back_aisle')
  final bool backAisle;

  const SeatModel({
    required this.id,
    required this.name,
    required this.seatRow,
    required this.leftAisle,
    required this.rightAisle,
    required this.frontAisle,
    required this.backAisle,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        seatRow,
        leftAisle,
        rightAisle,
        frontAisle,
        backAisle,
      ];
}
