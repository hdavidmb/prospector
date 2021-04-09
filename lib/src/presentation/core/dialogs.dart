import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showSnackBar({@required BuildContext context, @required String message}) {
  showFlash(
    context: context,
    duration: const Duration(milliseconds: 3000),
    builder: (context, controller) {
      return Flash.bar(
        controller: controller,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.all(10.0),
        borderRadius: BorderRadius.circular(8.0),
        child: FlashBar(
          icon: Icon(Icons.info, color: Theme.of(context).primaryColor),
          leftBarIndicatorColor: Theme.of(context).primaryColor,
          message: Text(
            message,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
      );
    },
  );
}
