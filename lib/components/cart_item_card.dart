import 'package:bookstore_app/components/spin_button.dart';
import 'package:bookstore_app/dto/cart.dart';
import 'package:bookstore_app/utils/constant.dart';
import 'package:bookstore_app/utils/util.dart' as util;
import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  final CartItem value;
  final void Function(CartItem) onChanged;
  final void Function() onDeleted;

  CartItemCard({
    @required this.value,
    @required this.onChanged,
    @required this.onDeleted,
  });

  void _handleActiveChanged(bool active) {
    final newValue = CartItem(
      book: value.book,
      amount: value.amount,
      active: active,
    );
    onChanged(newValue);
  }

  void _handleAmountChanged(int amount) {
    final newValue = CartItem(
      book: value.book,
      amount: amount,
      active: value.active,
    );
    onChanged(newValue);
  }

  void _handleDeleted() {
    onDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          right: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Checkbox(
              value: value.active,
              onChanged: _handleActiveChanged,
            ),
            Row(
              children: <Widget>[
                Image.memory(
                  util.dataUriToBytes(value.book.cover.data),
                  width: 80,
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 160,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            value.book.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            value.book.author,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff999999),
                            ),
                          ),
                          Text(
                            value.book.press,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        util.priceToString(value.book.price),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SpinButton(
                    value: value.amount,
                    min: MiscConst.cartItemAmountMin,
                    max: MiscConst.cartItemAmountMax,
                    onChanged: _handleAmountChanged,
                  ),
                  InkWell(
                    onTap: _handleDeleted,
                    child: Icon(
                      Icons.delete,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
