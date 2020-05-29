import 'package:bookstore_app/services/service.dart' as service;

Future<void> logout() async {
  await service.get('/logout');
}
