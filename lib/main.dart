import 'package:bookstore_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

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
