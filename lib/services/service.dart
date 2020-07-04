import 'dart:convert';
import 'dart:io';

import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/utils/constant.dart';
import 'package:bookstore_app/utils/global.dart' as global;
import 'package:http/http.dart' as http;

Future<Message> get(String path, Map<String, String> params) async {
  final url =
      Uri.http('${BackendConst.host}:${BackendConst.port}', path, params);

  final headers = <String, String>{};
  if (global.basic != null)
    headers[HttpHeaders.authorizationHeader] = 'Basic ${global.basic}';

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

Future<Message> post(
  String path,
  Map<String, String> params,
  Object obj,
) async {
  final url =
      Uri.http('${BackendConst.host}:${BackendConst.port}', path, params);

  final headers = <String, String>{
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  if (global.basic != null)
    headers[HttpHeaders.authorizationHeader] = 'Basic ${global.basic}';

  final body = json.encode(obj);

  try {
    final resp = await http.post(url, headers: headers, body: body);

    if (resp.statusCode != HttpStatus.ok &&
        resp.statusCode != HttpStatus.unauthorized)
      return Message(status: 'UNKNOWN_ERROR', data: null);

    return Message.fromJson(json.decode(resp.body));
  } catch (_) {
    return Message(status: 'UNKNOWN_ERROR', data: null);
  }
}
