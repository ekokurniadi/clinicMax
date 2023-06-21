import 'package:equatable/equatable.dart';

class AnnouncementModel extends Equatable {
  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
  });

  final int id;
  final String title;
  final String message;

  @override
  List<Object?> get props => [
        id,
        title,
        message,
      ];
}
