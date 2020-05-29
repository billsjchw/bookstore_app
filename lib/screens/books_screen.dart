import 'package:bookstore_app/components/app_bar.dart';
import 'package:bookstore_app/components/book_list_view.dart';
import 'package:bookstore_app/components/drawer.dart';
import 'package:bookstore_app/screens/user_screen.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
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
          width: 390,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Expanded(
                child: BookBrowser(
                  pageSize: 6,
                  colCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
