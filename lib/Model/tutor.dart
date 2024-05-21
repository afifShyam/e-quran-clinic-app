import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class Tutor {
  int? id;
  String? name;
  String? about;
  String? phone;
  String? email;
  String? password;
  String? profilePicture;
  int? age;
  String? gender;
  String? document;


  Tutor({
    this.id,
    this.name,
    this.phone,
    this.about,
    this.email,
    this.password,
    this.profilePicture,
    this.age,
    this.gender,
    this.document,
  });

  factory Tutor.fromJson(Map<String, dynamic> json) {
    return Tutor(
      id: json['id'] as int?, // Parse as int
      name: json['name'] as String?,
      phone: json['phone_num'] as String?,
      about: json['about'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      profilePicture: json['profile_picture'] as String?,
      age: json['age'] as int?, // Parse as int
      gender: json['gender'] as String?,
      document: json['document'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_num': phone,
      'about': about,
      'email': email,
      'password': password,
      'profile_picture': profilePicture,
      'age': age,
      'gender': gender,
      'document': document,
    };
  }
}
