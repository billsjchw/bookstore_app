import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:bookstore_app/components/book_details_data_table.dart';
import 'package:bookstore_app/components/divider_with_text.dart';
import 'package:bookstore_app/dto/book.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final Book book;

  BookView({@required this.book});

  @override
  Widget build(BuildContext context) {
    Uint8List coverBytes =
        convert.base64.decode(book.cover.data.split(',').last);
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 380,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 10,
                ),
                child: Image.memory(coverBytes),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      book.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      util.priceToString(book.price),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      util.stockDescription(book.stock),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              DividerWithText(text: 'Details'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: BookDetailsDataTable(book: book),
              ),
              DividerWithText(text: 'Introduction'),
              Container(
                child: Text(
                  book.intro.data,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 1.5,
                    color: Color(0xFF6F8398),
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
