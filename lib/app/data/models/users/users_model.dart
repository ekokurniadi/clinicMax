import 'package:equatable/equatable.dart';

class UsersModel extends Equatable {
  String? name;
  String? email;
  String? phone;
  String? icNumber;
  String? address;
  String? dob;
  String? gender;
  String? imageUrl;
  int? id;
  String? role;
  String? provider;
  String? firebaseUid;

  UsersModel({
    this.name,
    this.email,
    this.phone,
    this.icNumber,
    this.address,
    this.dob,
    this.gender,
    this.imageUrl,
    this.id,
    this.role,
    this.provider,
    this.firebaseUid,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      icNumber: json['ic_number'],
      address: json['address'],
      dob: json['dob'] != null ? json['dob'].toString() : null,
      gender: json['gender'],
      imageUrl: json['image_url'],
      id: json['id'],
      provider: json['provider'],
      firebaseUid: json['firebase_uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'ic_number': icNumber,
      'address': address,
      'dob': dob != null ? dob : dob,
      'gender': gender,
      'image_url': imageUrl,
      'role':'Patient',
      'provider':provider,
      'firebase_uid':firebaseUid,
    };
  }
  Map<String, dynamic> toPref() {
    return {
      'id':id,
      'name': name,
      'email': email,
      'phone': phone,
      'ic_number': icNumber,
      'address': address,
      'dob': dob != null ? dob : dob,
      'gender': gender,
      'image_url': imageUrl,
      'role':'Patient',
      'provider':provider,
      'firebase_uid':firebaseUid,
    };
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        icNumber,
        address,
        dob,
        gender,
        imageUrl,
        id,
        role,
      ];
}
