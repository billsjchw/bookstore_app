import 'package:flutter/material.dart';
import 'package:bookstore_app/dto/book.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:bookstore_app/services/cart_service.dart' as cart_service;

class AddToCartBar extends StatefulWidget {
  final Book book;

  AddToCartBar({@required this.book});

  @override
  State<StatefulWidget> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
  var _submitting = false;

  Future<void> _handleSubmit(BuildContext context) async {
    if (_submitting)
      return;

    _submitting = true;

    final msg = await cart_service.addBookToMyCart(widget.book.id);

    if (msg.status == 'SUCCESS')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    else if (msg.status == 'BOOK_NOT_FOUND')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Book not found')));
    else if (msg.status == 'MAX_AMOUNT_EXCEEDED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Max amount exceeded')));
    else if (msg.status == 'UNAUTHORIZED')
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please sign in first')));
    else
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error')));

    _submitting = false;
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 60,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text(
                  "ADD TO CART +",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F2F3E)
                  ),
                ),
                color: Colors.transparent,
                onPressed: () {
                  _handleSubmit(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  util.priceToString(widget.book.price),
                  style: TextStyle(
                      fontSize: 21,
                      color: Color(0xFF2F2F3E)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
