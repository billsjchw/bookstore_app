import 'package:bookstore_app/components/book_card_table.dart';
import 'package:bookstore_app/dto/book_page.dart';
import 'package:flutter/material.dart';

class BookGridView extends StatefulWidget {
  final int rowSize;
  final List<BookPage> bookPages;
  final void Function() onLoadMore;

  BookGridView({
    @required this.rowSize,
    @required this.bookPages,
    @required this.onLoadMore,
  });

  @override
  State<StatefulWidget> createState() => _BookGridViewState();
}

class _BookGridViewState extends State<BookGridView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange)
      widget.onLoadMore();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.bookPages.length,
      itemBuilder: (context, index) {
        return BookCardTable(
          rowSize: widget.rowSize,
          books: widget.bookPages[index].content,
        );
      },
    );
  }
}
