import 'package:bookstore_app/screens/books_screen.dart';
import 'package:flutter/material.dart';
import './screens/login_screen.dart';

void main() {
  runApp(Bookstore());
}

class Bookstore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookstore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
