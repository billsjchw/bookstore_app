import 'package:flutter/material.dart';

class Authority {
  final String name;

  Authority({@required this.name});

  factory Authority.fromJson(Map<String, dynamic> json) {
    return Authority(name: json['name']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'name': name};

  @override
  bool operator ==(dynamic other) => other is Authority && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
