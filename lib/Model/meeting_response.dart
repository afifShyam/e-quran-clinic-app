import 'dart:convert';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingResponse {
  final String meetingLink;

  MeetingResponse({required this.meetingLink});

  factory MeetingResponse.fromJson(Map<String, dynamic> json) {
    return MeetingResponse(
      meetingLink: json['meetingLink'],
    );
  }
}
