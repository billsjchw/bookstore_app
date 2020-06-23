import 'package:bookstore_app/components/book_grid_view.dart';
import 'package:bookstore_app/components/search_bar.dart';
import 'package:bookstore_app/dto/book_page.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/services/book_service.dart' as book_service;

class BookBrowser extends StatefulWidget {
  final int pageSize;
  final int rowSize;

  BookBrowser({
    @required this.pageSize,
    @required this.rowSize,
  });

  @override
  State<StatefulWidget> createState() => _BookBrowserState();
}

class _BookBrowserState extends State<BookBrowser> {
  var _page = 0;
  var _keyword = '';
  var _loading = false;
  final _bookPages = <BookPage>[];

  @override
  void initState() {
    super.initState();
    _handleReset();
  }

  Future<void> _handleLoadMore() async {
    if (_loading)
      return;

    _loading = true;
    ++_page;
    final msg = _keyword.isEmpty
        ? await book_service.findAllBooks(_page, widget.pageSize)
        : await book_service.bookFuzzySearch(_keyword, _page, widget.pageSize);
    setState(() {
      if (msg.status == 'SUCCESS')
        _bookPages.add(BookPage.fromJson(msg.data));
    });
    _loading = false;
  }

  Future<void> _handleSearch(String keyword) async {
    if (_loading)
      return;

    _loading = true;
    _page = 0;
    _keyword = keyword;
    final msg = _keyword.isEmpty
        ? await book_service.findAllBooks(_page, widget.pageSize)
        : await book_service.bookFuzzySearch(_keyword, _page, widget.pageSize);
    setState(() {
      _bookPages.clear();
      if (msg.status == 'SUCCESS')
        _bookPages.add(BookPage.fromJson(msg.data));
    });
    _loading = false;
  }

  Future<void> _handleReset() async {
    if (_loading)
      return;

    _loading = true;
    _page = 0;
    _keyword = '';
    final msg = await book_service.findAllBooks(0, widget.pageSize);
    setState(() {
      _bookPages.clear();
      if (msg.status == 'SUCCESS')
        _bookPages.add(BookPage.fromJson(msg.data));
    });
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          onSearch: _handleSearch,
          onReset: _handleReset,
        ),
        SizedBox(height: 5),
        Expanded(
          child: BookGridView(
            rowSize: widget.rowSize,
            bookPages: _bookPages,
            onLoadMore: _handleLoadMore,
          ),
        ),
      ],
    );
  }
}
