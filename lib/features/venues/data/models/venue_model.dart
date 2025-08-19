import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ticketing/features/venues/data/models/seat_row_model.dart'; // Import SeatRowModel

part 'venue_model.g.dart';

@JsonSerializable()
class VenueModel extends Equatable {
  final int id;
  final bool deleted;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String abbreviation;
  @JsonKey(name: 'seat_rows')
  final List<SeatRowModel> seatRows;

  const VenueModel({
    required this.id,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.abbreviation,
    required this.seatRows,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) =>
      _$VenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$VenueModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        deleted,
        createdAt,
        updatedAt,
        deletedAt,
        name,
        address,
        latitude,
        longitude,
        abbreviation,
        seatRows,
      ];
  static VenueModel empty() {
    return VenueModel(
      id: 0,
      deleted: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
      deletedAt: null,
      name: '',
      address: '',
      latitude: 0.0,
      longitude: 0.0,
      abbreviation: '',
      seatRows: [],
    );
  }
}
