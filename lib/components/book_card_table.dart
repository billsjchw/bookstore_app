import 'package:bookstore_app/components/book_card.dart';
import 'package:bookstore_app/dto/book.dart';
import 'package:flutter/material.dart';

class BookCardTable extends StatelessWidget {
  final List<Book> books;
  final int rowSize;

  BookCardTable({
    @required this.books,
    @required this.rowSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = books.length;
    final totalRows = size ~/ rowSize + (size % rowSize == 0 ? 0 : 1);

    final tableRows =
        List.generate(totalRows, (index) => TableRow(children: <Widget>[]));

    for (var i = 0; i < totalRows; ++i)
      for (var j = 0; j < rowSize; ++j) {
        final k = i * rowSize + j;
        if (k < size)
          tableRows[i].children.add(
            BookCard(book: books[k]),
          );
        else
          tableRows[i].children.add(
            Visibility(
              visible: false,
              child: BookCard(book: books.last),
            ),
          );
      }

    return Table(children: tableRows);
  }
}
