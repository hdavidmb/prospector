import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prospector/src/features/user/application/user_info_providers.dart';

class UserNameTextField extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final String userName = context.read(userInfoNotifierProvider).user.name;
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              initialValue: userName,
              textCapitalization: TextCapitalization.words,
              onChanged: (value) {
                //TODO user riverpod provider
                debugPrint(value);
              },
            ),
          );
  }
}