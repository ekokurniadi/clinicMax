import 'package:equatable/equatable.dart';

class MedicalRecordModel extends Equatable {
  int? id;
  int? clinicId;
  int? appointmentId;
  String? diagnosis;
  String? medication;
  String? procedures;
  String? therapies;
  String? instructions;
  String? progressNotes;
  String? followUpAppointment;

  MedicalRecordModel({
    this.id,
    this.appointmentId,
    this.clinicId,
    this.diagnosis,
    this.followUpAppointment,
    this.instructions,
    this.medication,
    this.procedures,
    this.progressNotes,
    this.therapies,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'],
      clinicId: json['clinic_id'],
      appointmentId: json['appointment_id'],
      diagnosis: json['diagnosis'],
      followUpAppointment: json['follow_up_appointment'],
      instructions: json['instructions'],
      medication: json['medication'],
      procedures: json['procedures'],
      progressNotes: json['progress_notes'],
      therapies: json['therapies'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        clinicId,
        diagnosis,
        followUpAppointment,
        instructions,
        medication,
        procedures,
        progressNotes,
        therapies,
      ];
}
