import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  DividerWithText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(text),
        ),
        Expanded(
          child: Divider(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
