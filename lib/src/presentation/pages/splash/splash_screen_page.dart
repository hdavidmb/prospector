import 'package:flutter/material.dart';


class SplashScreenPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.account_circle), //TODO place prospector logo
          SizedBox(height: 20.0),
          Text('Prospector'), //TODO: localize strings and format
          SizedBox(height: 20.0),
          CircularProgressIndicator.adaptive()
        ]
      ),
   );
  }
}