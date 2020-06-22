import 'dart:convert';
import 'dart:io';

import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/utils/constant.dart';
import 'package:bookstore_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

Future<Message> get(String path, Map<String, String> params) async {
  final url = Uri.http('${Backend.host}:${Backend.port}', path, params);

  final headers = <String, String>{};
  if (global.basic != null)
    headers['Authorization'] = 'Basic ${global.basic}';

  try {
    final resp = await http.get(url, headers: headers);

    if (resp.statusCode != HttpStatus.ok &&
        resp.statusCode != HttpStatus.unauthorized)
      return Message(status: 'UNKNOWN_ERROR', data: null);

    return Message.fromJson(json.decode(resp.body));
  } catch (_) {
    return Message(status: 'UNKNOWN_ERROR', data: null);
  }
}
