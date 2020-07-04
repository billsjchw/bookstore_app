import 'package:bookstore_app/dto/book.dart';
import 'package:flutter/material.dart';

class Cart {
  final int id;
  final int userId;
  final Set<CartItem> items;

  Cart({
    @required this.id,
    @required this.userId,
    @required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      items: json['items'].map<CartItem>((e) => CartItem.fromJson(e)).toSet(),
    );
  }

  @override
  bool operator ==(other) {
    return other is Cart && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class CartItem {
  final Book book;
  final int amount;
  final bool active;

  CartItem({
    @required this.book,
    @required this.amount,
    @required this.active,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      book: Book.fromJson(json['book']),
      amount: json['amount'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'book': book.toJson(),
      'amount': amount,
      'active': active,
    };
  }

  @override
  bool operator ==(other) {
    return other is CartItem && other.book == book;
  }

  @override
  int get hashCode => book.hashCode;
}
