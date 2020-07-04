import 'package:flutter/material.dart';

class SpinButton extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final void Function(int) onChanged;

  SpinButton({
    @required this.value,
    @required this.min,
    @required this.max,
    @required this.onChanged,
  });

  void _handleSubtract() {
    if (value - 1 >= min && value - 1 <= max)
      onChanged(value - 1);
  }

  void _handleAdd() {
    if (value + 1 >= min && value + 1 <= max)
      onChanged(value + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Color(0xffc0c0c0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: _handleSubtract,
            child: Icon(Icons.remove),
          ),
          Text(value.toString()),
          GestureDetector(
            onTap: _handleAdd,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
