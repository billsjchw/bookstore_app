import 'package:bookstore_app/dto/book.dart';
import 'package:bookstore_app/dto/consignee.dart';
import 'package:bookstore_app/dto/order_items_in_my_cart_dto.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/services/order_service.dart' as order_service;

class CheckoutForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  var _submitting = false;
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  var _paymentMethod = 'ONLINE';

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  String _addressValidator(String value) {
    return value.isEmpty ? 'Address cannot be empty' : null;
  }

  String _phoneValidator(String value) {
    return value.isEmpty ? 'Phone cannot be empty' : null;
  }

  String _firstNameValidator(String value) {
    return value.isEmpty ? 'First name cannot be empty' : null;
  }

  String _lastNameValidator(String value) {
    return value.isEmpty ? 'Last name cannot be empty' : null;
  }

  Future<void> _handleSubmit(context) async {
    if (_submitting)
      return;

    if (!_formKey.currentState.validate())
      return;

    _submitting = true;

    final address = _addressController.text;
    final phone = _phoneController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;

    final consignee = Consignee(
      address: address,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
    );
    final dto = OrderItemsInMyCartDto(
      consignee: consignee,
      paymentMethod: 'COD',
    );

    final msg = await order_service.orderItemsInMyCart(dto);

    if (msg.status == 'SUCCESS') {
      Navigator.pop(context);
    } else if (msg.status == 'NOTHING_TO_ORDER') {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Nothing to order')));
    } else if (msg.status == 'OUT_OF_STOCK') {
      final book = Book.fromJson(msg.data);
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Book ${book.title} is out of stock')));
    } else if (msg.status == 'UNAUTHORIZED') {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Please sign in first')));
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error')));
    }

    _submitting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Consignee',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _addressController,
            validator: _addressValidator,
            decoration: InputDecoration(
              labelText: 'Address',
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: _phoneController,
            validator: _phoneValidator,
            decoration: InputDecoration(
              labelText: 'Phone',
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: _firstNameController,
            validator: _firstNameValidator,
            decoration: InputDecoration(
              labelText: 'First name',
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: _lastNameController,
            validator: _lastNameValidator,
            decoration: InputDecoration(
              labelText: 'Last name',
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('Online payment'),
            leading: Radio(
              value: 'ONLINE',
              groupValue: _paymentMethod,
              onChanged: (String value) {
                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            title: const Text('Cash on delivery'),
            leading: Radio(
              value: 'COD',
              groupValue: _paymentMethod,
              onChanged: (String value) {
                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
          ),
          SizedBox(height: 5),
          RaisedButton(
            onPressed: () {
              _handleSubmit(context);
            },
            child: Text('Continue to checkout'),
          ),
        ],
      ),
    );
  }
}
