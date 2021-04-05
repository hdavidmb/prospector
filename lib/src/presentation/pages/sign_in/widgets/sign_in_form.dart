import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      return Column(
        children: [
          TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email', //TODO localize
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10.0),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password', //TODO localize
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => debugPrint('Signing In...'),
              child: Text('Sign In'), //TODO localize
            ),
          ) ,
        ],
      );
    });
  }
}
