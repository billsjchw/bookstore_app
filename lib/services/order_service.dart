import 'package:bookstore_app/dto/message.dart';
import 'package:bookstore_app/dto/order_items_in_my_cart_dto.dart';
import 'package:bookstore_app/services/service.dart' as service;

Future<Message> orderItemsInMyCart(OrderItemsInMyCartDto dto) {
  final obj = dto.toJson();
  return service.post('/order/order-items-in-my-cart', null, obj);
}
