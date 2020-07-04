import 'package:bookstore_app/components/bookstore_drawer.dart';
import 'package:bookstore_app/components/cart_manager.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      drawer: BookstoreDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: CartManager(),
      ),
    );
  }
}
