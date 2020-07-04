import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> login() {
  return service.get('/login', null);
}
