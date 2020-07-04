import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final void Function(String) onSearch;
  final void Function() onReset;

  SearchBar({
    @required this.onSearch,
    @required this.onReset,
  });

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _keywordController = TextEditingController();

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  void _handleSearch(keyword) {
    widget.onSearch(keyword);
  }

  void _handleReset() {
    _keywordController.clear();
    widget.onReset();
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
        InkWell(
          onTap: _handleReset,
          child: Text(
            'Reset',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
