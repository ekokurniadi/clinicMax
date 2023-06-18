import 'package:equatable/equatable.dart';

class ClinicModel extends Equatable {
  final int id;
  final String name;
  final int stateId;
  final String contact;
  final String address;

  ClinicModel({
    required this.id,
    required this.name,
    required this.stateId,
    required this.contact,
    required this.address,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json) {
    return ClinicModel(
      id: json['id'],
      name: json['name'],
      stateId: json['state_id'],
      contact: json['contact'],
      address: json['address'],
    );
  }

  factory ClinicModel.initial(){
    return ClinicModel(id: 0, name: '', stateId: 0, contact: '', address: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
      'contact': contact,
      'address': address,
    };
  }

  @override
  List<Object?> get props => [id, name,contact,stateId,address];
}
