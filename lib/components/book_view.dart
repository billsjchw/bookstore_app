import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:bookstore_app/components/divider_with_text.dart';
import 'package:bookstore_app/entities/book.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:flutter/material.dart';

class BookView extends StatelessWidget {
  final Book book;

  BookView({@required this.book});

  @override
  Widget build(BuildContext context) {
    Uint8List coverBytes = convert.base64.decode(
        book.cover.data.split(',').last
    );
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
                      '\uffe5${(book.price/100).toStringAsFixed(2)}',
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
              DividerWithText(
                text: 'Detail',
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: BookDetailTable(
                  book: book,
                ),
              ),
              DividerWithText(
                text: 'Introduction',
              ),
              Container(
                child: Text(
                  book.introduction.data,
                  textAlign: TextAlign.justify,
                  style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookDetailTable extends StatelessWidget {
  final Book book;
  static const _columns = <String>['Attribute', 'Value'];

  BookDetailTable({@required this.book});

  Map<String, String> get _data => <String, String>{
    'ISBN' : book.isbn,
    'Title': book.title,
    'Author': book.author,
    'Language': book.language,
    'Press': book.press,
    'Publication date': '${book.date.year}-${book.date.month}-${book.date.day}',
    'Price': '\uffe5${(book.price/100).toStringAsFixed(2)}',
    'Stock': book.stock.toString(),
  };

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 0,
      columns: _columns.map(
        (col) => DataColumn(
          label: SizedBox(),
        ),
      ).toList(),
      rows: _data.entries.map(
        (entry) => DataRow(
          cells: <DataCell>[
            DataCell(Text(entry.key)),
            DataCell(Text(entry.value)),
          ],
        ),
      ).toList(),
    );
  }
}
