import 'package:flutter/material.dart';

class Message {
  final String status;
  final dynamic data;

  Message({
    @required this.status,
    @required this.data
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      status: json['status'],
      data: json['data'],
    );
  }
}
