import 'dart:convert';

import 'package:bookstore_app/dto/user.dart';
import 'package:bookstore_app/screens/home_screen.dart';
import 'package:bookstore_app/services/login_service.dart' as login_service;
import 'package:bookstore_app/utils/global.dart' as global;
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var _submitting = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _usernameValidator(String value) {
    return value.isEmpty ? 'Username cannot be empty' : null;
  }

  String _passwordValidator(String value) {
    return value.isEmpty ? 'Password cannot be empty' : null;
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (_submitting) return;

    if (!_formKey.currentState.validate()) return;

    _submitting = true;

    final username = _usernameController.text;
    final password = _passwordController.text;
    global.basic = base64.encode(utf8.encode('$username:$password'));

    final msg = await login_service.login();

    if (msg.status == 'SUCCESS') {
      global.user = User.fromJson(msg.data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (msg.status == 'UNAUTHORIZED') {
      global.basic = null;
      final reason = msg.data as String;
      if (reason == 'WRONG_PASSWORD')
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Wrong username/password')));
      else
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Your account is disabled')));
    } else {
      global.basic = null;
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Unknown error')));
    }

    _submitting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Wrap(
        children: <Widget>[
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 110,
                  height: 110,
                ),
                Text(
                  'Bookstore',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _usernameController,
                  validator: _usernameValidator,
                  decoration: InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: _passwordValidator,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 25),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 48,
                  child: RaisedButton(
                    onPressed: () {
                      _handleSubmit(context);
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
