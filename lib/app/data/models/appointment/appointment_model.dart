import 'package:equatable/equatable.dart';

class AppointmentModel extends Equatable {
  final int id;
  final int clinicId;
  final String appointmentDate;
  final String appointmentTime;
  final bool isFromKiosk;
  final int userId;
  final int queueNumber;

  AppointmentModel({
    required this.id,
    required this.clinicId,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.isFromKiosk,
    required this.userId,
    required this.queueNumber,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      clinicId: json['clinic_id'],
      appointmentDate: json['appointment_date'],
      appointmentTime: json['appointment_time'],
      isFromKiosk: json['is_from_kiosk'],
      userId: json['user_id'],
      queueNumber: json['queue_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinic_id': clinicId,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'user_id': userId,
      'queue_number': queueNumber,
    };
  }

  @override
  List<Object?> get props => [
        id,
        clinicId,
        appointmentDate,
        appointmentTime,
        isFromKiosk,
        userId,
        queueNumber,
      ];
}
