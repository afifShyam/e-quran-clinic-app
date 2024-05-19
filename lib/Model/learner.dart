import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class Learner {
  int? id;
  String? name;
  String? gender;
  int? age;
  String? phone;
  String? password;
  String? proficientLevel;
  int tutorID;

  Learner({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.phone,
    this.password,
    this.proficientLevel,
    required this.tutorID,
  });

  factory Learner.fromJson(Map<String, dynamic> json) {
    return Learner(
      id: json['id'] as int?, // Parse as int
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?, // Parse as int
      phone: json['phone_num'] as String?,
      password: json['password'] as String?,
      proficientLevel: json['proficiency_level'] as String?,
      tutorID: json['tutorID'] as int, // Parse as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'phone_num': phone,
      'password': password,
      'proficiency_Level': proficientLevel,
      'tutorID': tutorID,
    };
  }
}
