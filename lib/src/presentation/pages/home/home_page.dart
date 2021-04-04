import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home')
      ),
      body: Center(
        child: Consumer(
          builder: (context, watch, child) {
            return ElevatedButton(onPressed: null, child: Text('Sign out'));
          }
        ),
        
    )
    );
  }
}