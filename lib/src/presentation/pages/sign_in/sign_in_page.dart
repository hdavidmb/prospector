import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/presentation/pages/sign_in/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ProviderListener(
        provider: null,
        onChange: (context, value) {},
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: screenSize.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Welcome to', style: TextStyle(fontSize: 30.0)), //TODO localize
                SizedBox(height: 8.0),
                Text('Prospector', style: TextStyle(fontSize: 60.0)), //TODO localize
                SizedBox(height: 30.0),
                SignInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
