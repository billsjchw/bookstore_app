import 'package:flutter/material.dart';

class Authority {
  final int id;
  final String name;

  Authority({
    @required this.id,
    @required this.name,
  });

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
  };

  @override
  bool operator ==(dynamic other) => other is Authority && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
