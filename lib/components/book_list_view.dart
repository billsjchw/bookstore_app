import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:bookstore_app/entities/book.dart';
import 'package:bookstore_app/entities/book_page.dart';
import 'package:bookstore_app/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/services/book_service.dart' as book_service;

class BookBrowser extends StatefulWidget {
  final int pageSize;
  final int colCount;

  BookBrowser({
    @required this.pageSize,
    @required this.colCount,
  });

  @override
  State<StatefulWidget> createState() => _BookBrowserState();
}

class _BookBrowserState extends State<BookBrowser> {
  int _pageIndex;
  bool _search;
  String _keyword;
  bool _loading;
  final _pages = <Future<BookPage>>[];

  @override
  void initState() {
    super.initState();
    _pageIndex = 0;
    _search = false;
    _keyword = "";
    _loading = true;
    _pages.add(
      book_service
        .findAllBooks(_pageIndex, widget.pageSize)
        .whenComplete(() { _loading = false; })
    );
  }

  void _handleLoadMore() {
    if (_loading)
      return;
    _loading = true;
    setState(() {
      ++_pageIndex;
      if (!_search)
        _pages.add(
          book_service
            .findAllBooks(_pageIndex, widget.pageSize)
            .whenComplete(() { _loading = false; })
        );
      else
        _pages.add(
          book_service
            .bookFuzzySearch(_keyword, _pageIndex, widget.pageSize)
            .whenComplete(() { _loading = false; })
        );
    });
  }

  void _handleSearch(String keyword) {
    setState(() {
      _search = true;
      _keyword = keyword;
      _pageIndex = 0;
      _pages.clear();
      _loading = true;
      _pages.add(
        book_service
          .bookFuzzySearch(_keyword, _pageIndex, widget.pageSize)
          .whenComplete(() { _loading = false; })
      );
    });
  }

  void _handleCancel() {
    setState(() {
      _search = false;
      _pageIndex = 0;
      _pages.clear();
      _pages.add(book_service.findAllBooks(_pageIndex, widget.pageSize));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(
          onSearch: _handleSearch,
          onCancel: _handleCancel,
        ),
        SizedBox(height: 5),
        Expanded (
          child: BookGridView(
            colCount: widget.colCount,
            pages: _pages,
            onLoadMore: _handleLoadMore,
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  final void Function(String) onSearch;
  final void Function() onCancel;

  SearchBar({
    @required this.onSearch,
    @required this.onCancel,
  });

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _search = false;
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _handleSearch(String keyword) {
    setState(() {
      _search = true;
    });
    widget.onSearch(keyword);
  }

  void _handleCancel() {
    setState(() {
      _search = false;
      _keywordController.clear();
    });
    widget.onCancel();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _keywordController,
            onSubmitted: _handleSearch,
            decoration: InputDecoration(
              hintText: 'Search ...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(23),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 0,
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        if (_search)
          InkWell(
            onTap: _handleCancel,
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
      ],
    );
  }
}

class BookGridView extends StatefulWidget {
  final int colCount;
  final List<Future<BookPage>> pages;
  final void Function() onLoadMore;

  BookGridView({
    @required this.colCount,
    @required this.pages,
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
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent
        && !_scrollController.position.outOfRange)
      widget.onLoadMore();
  }

  List<TableRow> _buildTableRows(BookPage page) {
    final content = page.content;
    return <TableRow>[
      for (var r = 0; r * widget.colCount < content.length; ++r)
        TableRow(
          children: <Widget>[
            for (var c = 0; c < widget.colCount &&
                r * widget.colCount + c < content.length; ++c)
              BookCard(book: content[r * widget.colCount + c]),
            if ((r + 1) * widget.colCount - 1 >= content.length)
              for (var c = content.length - r * widget.colCount;
                  c < widget.colCount; ++c)
                Visibility(
                  visible: false,
                  child: BookCard(book: content.last),
                ),
          ],
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widget.pages.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: widget.pages[index],
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Table(
                children: _buildTableRows(snapshot.data),
              );
            else if (snapshot.hasError)
              return SizedBox();
            else
              return Center(
                child: CircularProgressIndicator()
              );
          }
        );
      },
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  BookCard({@required this.book});

  @override
  Widget build(BuildContext context) {
    Uint8List coverBytes = convert.base64.decode(
      book.cover.data.split(',').last
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BookScreen(book: book),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.memory(coverBytes),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    book.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '\uffe5${(book.price/100).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
