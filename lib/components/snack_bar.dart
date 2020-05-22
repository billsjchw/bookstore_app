import 'package:flutter/material.dart';

class HintSnakeBar extends SnackBar {
  final String hint;

  HintSnakeBar({@required this.hint}) : super(
    backgroundColor: Colors.blue,
    content: Text(hint),
  );
}

class LoadingSnakeBar extends SnackBar {
  LoadingSnakeBar() : super(
    duration: Duration(minutes: 10),
    backgroundColor: Colors.blue,
    content: Row(
      children: <Widget>[
        Text('Loading ...'),
      ],
    ),
  );
}
