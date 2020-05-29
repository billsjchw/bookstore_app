import 'package:bookstore_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstore_app/services/logout_service.dart' as logout_service;

class LogoutButton extends StatelessWidget {
  void _handleLogout(BuildContext context) {
    logout_service.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      child: OutlineButton(
        onPressed: () { _handleLogout(context); },
        borderSide: BorderSide(
          color: Colors.red,
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
