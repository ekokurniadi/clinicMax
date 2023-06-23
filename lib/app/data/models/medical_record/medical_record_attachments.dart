import 'package:equatable/equatable.dart';

class MedicalRecordAttachments extends Equatable {
  final int id;
  final int medicalRecordId;
  final String attachment;

  const MedicalRecordAttachments({
    required this.id,
    required this.medicalRecordId,
    required this.attachment,
  });

  factory MedicalRecordAttachments.fromJson(Map<String, dynamic> json) {
    return MedicalRecordAttachments(
      id: json['id'],
      medicalRecordId: json['medical_record_id'],
      attachment: json['attachment'],
    );
  }

  @override
  List<Object?> get props => [id, medicalRecordId, attachment];
}
