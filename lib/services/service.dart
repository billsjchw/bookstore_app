import 'dart:io';

import 'package:bookstore_app/utils/constant.dart';
import 'package:bookstore_app/utils/exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> get(String uri) async {
  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('basic'))
    throw HttpStatusException(status: HttpStatus.unauthorized);
  final basic = prefs.getString('basic');
  final resp = await http.get(
    '${BackendInfo.domain}$uri',
    headers: <String, String>{
      'Authorization': 'Basic $basic',
    },
  );
  if (resp.statusCode != HttpStatus.ok
      && resp.statusCode != HttpStatus.noContent)
    throw HttpStatusException(status: resp.statusCode);
  return resp;
}
