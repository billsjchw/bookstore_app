import 'package:bookstore_app/components/add_to_cart_bar.dart';
import 'package:bookstore_app/components/app_bar.dart';
import 'package:bookstore_app/components/book_view.dart';
import 'package:bookstore_app/entities/book.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  final Book book;

  BookScreen({@required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookstoreAppBar(),
      bottomNavigationBar: AddToCartBar(
        book: book,
      ),
      body: BookView(book: book),
    );
  }
}
