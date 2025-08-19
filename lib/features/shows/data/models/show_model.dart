// lib/features/shows/data/models/show_model.dart

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
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime? date;
  @JsonKey(fromJson: _timeFromJson, toJson: _timeToJson)
  final DateTime? time;
  final String? banner;
  @JsonKey(name: 'show_type')
  final String? showType;
  final int? merchant;
  final int? venue;
  final List<dynamic>? tickets;

  const ShowModel({
    this.id,
    this.deleted = false,
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
    this.tickets,
  });

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$ShowModelToJson(this);

    if (data['deleted'] == null) {
      data['deleted'] = false;
    }
    return data;
  }

  static DateTime? _dateFromJson(String? dateString) {
    if (dateString == null) return null;
    return DateTime.tryParse(dateString);
  }

  static String? _dateToJson(DateTime? date) {
    if (date == null) return null;
    return date.toIso8601String().split('T')[0];
  }

  static DateTime? _timeFromJson(String? timeString) {
    if (timeString == null) return null;
    final now = DateTime.now();
    final parts = timeString.split(':');
    if (parts.length >= 2) {
      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour != null && minute != null) {
        return DateTime(now.year, now.month, now.day, hour, minute);
      }
    }
    return null;
  }

  static String? _timeToJson(DateTime? time) {
    if (time == null) return null;
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:00';
  }

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
        tickets,
      ];
}
