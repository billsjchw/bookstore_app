import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> login() async {
  return await service.get('/login', null);
}
