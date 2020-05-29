import 'package:flutter/material.dart';
import 'package:bookstore_app/entities/book.dart';

class AddToCartBar extends StatelessWidget {
  final Book book;

  AddToCartBar({@required this.book});

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
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '\uffe5${(book.price/100).toStringAsFixed(2)}',
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
