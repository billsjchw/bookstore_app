import 'package:bookstore_app/dto/authority.dart';
import 'package:flutter/material.dart';

class Role {
  final int id;
  final String name;
  final Set<Authority> authorities;

  Role({
    @required this.id,
    @required this.name,
    @required this.authorities,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      authorities: json['authorities']
          .map<Authority>((e) => Authority.fromJson(e)).toSet(),
    );
  }
}
