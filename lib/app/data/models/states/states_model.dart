import 'package:equatable/equatable.dart';

class StatesModel extends Equatable {
  final String name;
  final int id;

  StatesModel({
    required this.name,
    required this.id,
  });

  factory StatesModel.fromJson(Map<String, dynamic> json) {
    return StatesModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [id,name];
}
