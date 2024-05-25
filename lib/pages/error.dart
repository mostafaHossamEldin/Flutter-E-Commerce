import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (message == 'not authorised') {
      content = const Center(
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
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/signup');
              },
              child: const Text('Create a New Account'),
            ),
          ],
        ),
      );
    } else if (message == 'product count zero') {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('The product is no longer in stock',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Navigate Back to Home'),
            ),
          ],
        ),
      );
    } else {
      content = const Center(
        child: Text('An unknown error occurred',
            style: TextStyle(fontSize: 18, color: Colors.red)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: content,
    );
  }
}
