import 'package:bookstore_app/components/cart_item_card.dart';
import 'package:bookstore_app/dto/cart.dart';
import 'package:bookstore_app/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/services/cart_service.dart' as cart_service;
import 'package:bookstore_app/utils/util.dart' as util;

class CartManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartManagerState();
}

class _CartManagerState extends State<CartManager> {
  Future<Cart> _future;
  bool _submitting;

  @override
  void initState() {
    super.initState();
    _future = _fetchCart();
    _submitting = false;
  }

  Future<Cart> _fetchCart() async {
    final msg = await cart_service.findMyCart();
    if (msg.status == 'SUCCESS')
      return Cart.fromJson(msg.data);
    else
      throw Exception('Failed to fetch your cart');
  }

  Future<void> _handleCartItemChanged(
    CartItem cartItem,
    Cart cart,
    BuildContext context,
  ) async {
    if (_submitting) return;

    _submitting = true;
    final msg = await cart_service.editItemInMyCart(cartItem);
    print(msg.status);
    if (msg.status == 'SUCCESS')
      setState(() {
        cart.items.remove(cartItem);
        cart.items.add(cartItem);
      });
    else if (msg.status == 'UNAUTHORIZED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please sign in first')));
    else if (msg.status == 'ITEM_NOT_FOUND')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Item not found')));
    else if (msg.status == 'MIN_AMOUNT_EXCEEDED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Min amount exceeded')));
    else if (msg.status == 'MAX_AMOUNT_EXCEEDED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Max amount exceeded')));
    else
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error')));
    _submitting = false;
  }

  Future<void> _handleCartItemDeleted(
    CartItem cartItem,
    Cart cart,
    BuildContext context,
  ) async {
    if (_submitting) return;

    _submitting = true;
    final msg = await cart_service.deleteItemFromMyCart(cartItem.book.id);
    print(msg.status);
    if (msg.status == 'SUCCESS')
      setState(() {
        cart.items.remove(cartItem);
      });
    else if (msg.status == 'UNAUTHORIZED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please sign in first')));
    else
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error')));
    _submitting = false;
  }

  List<TableRow> _buildTableRows(Cart cart, BuildContext context) {
    final cartItems = cart.items.toList();
    cartItems.sort((a, b) {
      if (a.book.id < b.book.id)
        return -1;
      else if (a.book.id > b.book.id)
        return 1;
      else
        return 0;
    });
    return cartItems.map((e) {
      return TableRow(
        children: <Widget>[
          CartItemCard(
            value: e,
            onChanged: (cartItem) {
              _handleCartItemChanged(cartItem, cart, context);
            },
            onDeleted: () {
              _handleCartItemDeleted(e, cart, context);
            },
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        else if (snapshot.hasError)
          return Center(child: Text(snapshot.error.toString()));
        else {
          final cart = snapshot.data as Cart;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Table(
                  children: _buildTableRows(cart, context),
                ),
                SizedBox(height: 5),
                Text(
                  'Total Price: ${util.priceToString(util.cartTotalPrice(cart))}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: Text('GO TO CHECKOUT'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
