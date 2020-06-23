import 'package:bookstore_app/dto/book.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:flutter/material.dart';

class BookDetailsDataTable extends StatelessWidget {
  final Book book;

  BookDetailsDataTable({@required this.book});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 0,
      columns: <DataColumn>[
        DataColumn(label: SizedBox()),
        DataColumn(label: SizedBox()),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('ISBN')),
            DataCell(Text(book.isbn)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Title')),
            DataCell(Text(book.title)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Author')),
            DataCell(Text(book.author)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Language')),
            DataCell(Text(book.lang)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Press')),
            DataCell(Text(book.press)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('ISBN')),
            DataCell(Text(book.isbn)),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Publication Date')),
            DataCell(Text(util.dateToString(book.date))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Price')),
            DataCell(Text(util.priceToString(book.price))),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Stock')),
            DataCell(Text(book.stock.toString())),
          ],
        ),
      ],
    );
  }
}
