import 'package:bookstore_app/components/app_bar.dart';
import 'package:bookstore_app/components/drawer.dart';
import 'package:bookstore_app/components/logout_button.dart';
import 'package:bookstore_app/screens/books_screen.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookstoreAppBar(),
      drawer: BookstoreDrawer(
        onTapBooks: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => BooksScreen(),
            ),
          );
        },
        onTapCart: () {},
        onTapOrders: () {},
        onTapUser: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => UserScreen(),
            ),
          );
        },
      ),
      body: Center(
        child: SizedBox(
          width: 370,
          child: Column(
            children: <Widget>[
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
