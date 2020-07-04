import 'package:bookstore_app/components/book_browser.dart';
import 'package:bookstore_app/components/bookstore_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: BookstoreDrawer(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: BookBrowser(
          pageSize: 6,
          rowSize: 2,
        ),
      ),
    );
  }
}
