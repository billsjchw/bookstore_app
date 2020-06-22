import 'package:flutter/material.dart';

class Authority {
  final int id;
  final String name;

  Authority({
    @required this.id,
    @required this.name
  });

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  bool operator ==(other) {
    return other is Authority && other.id == id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;
}
