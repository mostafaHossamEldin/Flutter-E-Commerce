import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (message == 'not authorised') {
      content = Center(
        child: Text('You do not have access',
            style: TextStyle(fontSize: 18, color: Colors.red)),
      );
    } else if (message == 'not authenticated') {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/signup');
              },
              child: Text('Create a New Account'),
            ),
          ],
        ),
      );
    } else if (message == 'product count zero') {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('The product is no longer in stock',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: Text('Navigate Back to Home'),
            ),
          ],
        ),
      );
    } else {
      content = Center(
        child: Text('An unknown error occurred',
            style: TextStyle(fontSize: 18, color: Colors.red)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Error'),
      ),
      body: content,
    );
  }
}
