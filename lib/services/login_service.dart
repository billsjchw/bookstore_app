import 'dart:convert' as convert;

import 'package:bookstore_app/entities/authority.dart';
import 'package:bookstore_app/utils/message.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> login() async {
  final resp = await service.get('/login');
  final json = convert.json.decode(resp.body);
  final status = json['status'] as String;
  final authorities = <Authority>[
    for (var item in json['data'] as List)
      Authority.fromJson(item)
  ];
  return Message(status: status, data: authorities);
}
