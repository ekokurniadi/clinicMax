import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  final String time;

  const TimeSlot({
    required this.time,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      time: json['time'],
    );
  }

  TimeSlot copyWith({
    String? time,
  }) {
    return TimeSlot(
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props => [
        time,
      ];
}

class TimeSlots extends Equatable {
  final String days;
  final List<TimeSlot> slots;

  const TimeSlots({required this.days, required this.slots});

  @override
  List<Object?> get props => [
        days,
        slots,
      ];
}
