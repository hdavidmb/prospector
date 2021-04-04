import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/application/auth/auth_state.dart';

import 'package:prospector/src/application/auth/auth_providers.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Center(
        child: Consumer(
          builder: (context, watch, child) {
            final _authState = watch(authStateNotifierProvider.state);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(tag: 'logo',
                child: Icon(Icons.supervised_user_circle_outlined, size: 200.0,)),
                const SizedBox(height: 20.0),

                ElevatedButton(
                  onPressed: null,
                  child: const Text('Sign Up'),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
