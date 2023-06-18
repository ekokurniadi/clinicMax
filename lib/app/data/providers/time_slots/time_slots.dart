import 'package:clinic_max/app/data/constant/jsondata.dart';
import 'package:clinic_max/app/data/models/time_slots/time_slots.dart';

class TimeSlotsProvider {
  const TimeSlotsProvider._();

  static Future<TimeSlots> getTimeSlot(String days) async {
    TimeSlots timeSlots = TimeSlots(
      days: days.toLowerCase(),
      slots: [],
    );

    for (var element in clinicTiming.entries) {
      if (element.key == days.toLowerCase()) {
        timeSlots = TimeSlots(
          days: element.key,
          slots: List<TimeSlot>.from(
            element.value.map(
              (e) => TimeSlot.fromJson(e),
            ),
          ),
        );
        break;
      }
    }

    return timeSlots;
  }
}
