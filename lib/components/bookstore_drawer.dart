import 'package:bookstore_app/screens/cart_screen.dart';
import 'package:bookstore_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BookstoreDrawer extends Drawer {
  BookstoreDrawer(BuildContext context)
      : super(
    child: ListView(
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
                image: AssetImage('assets/images/logo.png'),
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
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Orders'),
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Account'),
        ),
      ],
    ),
  );
}
