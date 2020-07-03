import 'package:bookstore_app/dto/cart.dart';
import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> addBookToMyCart(int bookId) {
  final params = <String, String>{
    'book-id': bookId.toString(),
  };
  return service.get('/cart/add-book-to-my-cart', params);
}

Future<Message> findMyCart() {
  return service.get('/cart/find-my-cart', null);
}

Future<Message> editItemInMyCart(CartItem cartItem) {
  final obj = cartItem.toJson();
  return service.post('/cart/edit-item-in-my-cart', null, obj);
}

Future<Message> deleteItemFromMyCart(int bookId) {
  final params = <String, String> {
    'book-id': bookId.toString(),
  };
  return service.get('/cart/delete-item-from-my-cart', params);
}
