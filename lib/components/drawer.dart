import 'package:flutter/material.dart';

class BookstoreDrawer extends Drawer {
  final void Function() onTapBooks;
  final void Function() onTapCart;
  final void Function() onTapOrders;
  final void Function() onTapUser;
  
  BookstoreDrawer({
    @required this.onTapBooks,
    @required this.onTapCart,
    @required this.onTapOrders,
    @required this.onTapUser,
  }) : super(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('images/books.png'),
                height: 80,
                width: 80,
              ),
              Text(
                'Bookstore',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.book),
          title: Text('Books'),
          onTap: onTapBooks,
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          onTap: onTapCart,
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Orders'),
          onTap: onTapOrders,
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('User'),
          onTap: onTapUser,
        )
      ],
    ),
  );
}
