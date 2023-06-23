import 'package:equatable/equatable.dart';

class MedicalRecordModel extends Equatable {
  final int id;
  final int clinicId;
  final int appointmentId;
  final int doctorId;
  final String medicalRecordForm;
  final String createdAt;

  MedicalRecordModel({
    required this.id,
    required this.appointmentId,
    required this.clinicId,
    required this.doctorId,
    required this.medicalRecordForm,
    this.createdAt = '',
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'],
      clinicId: json['clinic_id'],
      appointmentId: json['appointment_id'],
      doctorId: json['doctor_id'],
      medicalRecordForm: json['medical_record_form'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clinic_id': clinicId,
      'appointment_id': appointmentId,
      'doctor_id': doctorId,
      'medical_record_form': medicalRecordForm,
    };
  }

  @override
  List<Object?> get props => [
        id,
        appointmentId,
        clinicId,
        doctorId,
        medicalRecordForm,
        createdAt,
      ];
}
