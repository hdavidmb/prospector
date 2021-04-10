import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prospector/src/features/auth/application/auth_providers.dart';
import 'package:prospector/src/presentation/pages/home/home_page.dart';
import 'package:prospector/src/presentation/pages/register/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ProviderListener<AuthState>(
        provider: authStateNotifierProvider.state,
        onChange: (context, authState) {
          authState.maybeWhen(
            authenticated: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())), //TODO implement proper navigation or routing
            orElse: () {},
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // Hero(tag: 'prospector_logo', child: Icon(Icons.account_circle, size: 100.0,)), //TODO place prospector logo
                Text('Register',
                    style: TextStyle(fontSize: 30.0)), //TODO localize
                SizedBox(height: 8.0),
                // Text('Prospector',
                //     style: TextStyle(fontSize: 60.0)), //TODO localize
                SizedBox(height: 30.0),
                RegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}