import 'package:flutter/material.dart';

class Consignee {
  final String address;
  final String phone;
  final String firstName;
  final String lastName;

  Consignee({
    @required this.address,
    @required this.phone,
    @required this.firstName,
    @required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': this.address,
      'phone': this.phone,
      'firstName': this.firstName,
      'lastName': this.lastName,
    };
  }
}
