import 'package:bookstore_app/dto/book.dart';
import 'package:bookstore_app/screens/book_screen.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({@required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookScreen(book: book)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.memory(
                  util.dataUriToBytes(book.cover.data),
                  height: 200,
                ),
              ),
              SizedBox(height: 5),
              Text(
                book.title,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                book.author,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                util.priceToString(book.price),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
