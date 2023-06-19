import 'package:equatable/equatable.dart';

class QueueModel extends Equatable {
  final int id;
  final int clinicId;
  final DateTime queueDate;
  final int queueNumber;
  final DateTime lastUpdate;

  QueueModel({
    required this.id,
    required this.clinicId,
    required this.queueDate,
    required this.queueNumber,
    required this.lastUpdate,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
      id: json['id'],
      clinicId: json['clinic_id'],
      queueDate: json['queue_date'],
      queueNumber: json['queue_number'],
      lastUpdate: json['last_update'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinic_id': clinicId,
      'queue_date': queueDate,
      'queue_number': queueNumber,
      'last_update': lastUpdate,
    };
  }

  @override
  List<Object?> get props => [
        id,
        clinicId,
        queueDate,
        queueNumber,
        lastUpdate,
      ];
}
