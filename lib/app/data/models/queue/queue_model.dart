import 'package:equatable/equatable.dart';

class QueueModel extends Equatable {
  final int id;
  final int clinicId;
  final int queueNumber;
  final DateTime lastUpdate;

  QueueModel({
    required this.id,
    required this.clinicId,
    required this.queueNumber,
    required this.lastUpdate,
  });

  factory QueueModel.fromJson(Map<String, dynamic> json) {
    return QueueModel(
      id: json['id'],
      clinicId: json['clinic_id'],
      queueNumber: json['queue_number'],
      lastUpdate: DateTime.parse(json['last_update']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clinic_id': clinicId,
      'queue_number': queueNumber,
    };
  }

  @override
  List<Object?> get props => [
        id,
        clinicId,
        queueNumber,
        lastUpdate,
      ];
}
