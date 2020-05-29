import 'dart:io';
import 'dart:ui';
import 'dart:convert' as convert;

import 'package:bookstore_app/components/snack_bar.dart';
import 'package:bookstore_app/screens/books_screen.dart';
import 'package:bookstore_app/services/login_service.dart' as login_service;
import 'package:bookstore_app/utils/exception.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final bytes = convert.utf8.encode('$username:$password');
    final basic = convert.base64.encode(bytes);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('basic', basic);
    var msg;
    try {
      msg = await login_service.login();
    } on HttpStatusException catch (e) {
      prefs.remove('basic');
      if (e.status == HttpStatus.unauthorized)
        Scaffold.of(context).showSnackBar(
          HintSnakeBar(hint: 'Wrong username/password'),
        );
      else
        Scaffold.of(context).showSnackBar(
          HintSnakeBar(hint: 'HTTP status code ${e.status}'),
        );
      return;
    } catch (_) {
      prefs.remove('basic');
      Scaffold.of(context).showSnackBar(
        HintSnakeBar(hint: 'Unknown error'),
      );
      return;
    }
    prefs.setString('authorities', convert.json.encode(msg.data));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => BooksScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Center(
                child: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/books.png'),
                        height: 110,
                        width: 110,
                      ),
                      Text(
                        'Bookstore',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      ButtonTheme(
                        minWidth: double.infinity,
                        height: 48,
                        child: RaisedButton(
                          onPressed: () {
                            _handleSignIn(context);
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
