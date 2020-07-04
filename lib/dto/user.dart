import 'package:bookstore_app/dto/role.dart';
import 'package:flutter/material.dart';

class User {
  final int id;
  final String username;
  final String password;
  final Profile profile;
  final bool enabled;
  final Set<Role> roles;
  final Avatar avatar;

  User({
    @required this.id,
    @required this.username,
    @required this.password,
    @required this.profile,
    @required this.enabled,
    @required this.roles,
    @required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      profile: Profile.fromJson(json['profile']),
      enabled: json['enabled'],
      roles: json['roles'].map<Role>((e) => Role.fromJson(e)).toSet(),
      avatar: Avatar.fromJson(json['avatar']),
    );
  }

  @override
  bool operator ==(other) {
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Profile {
  final String firstName;
  final String lastName;
  final String email;

  Profile({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  get name => '$firstName $lastName';
}

class Avatar {
  final int userId;
  final String data;

  Avatar({
    @required this.userId,
    @required this.data,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      userId: json['userId'],
      data: json['data'],
    );
  }

  @override
  bool operator ==(other) {
    return other is Avatar && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}
