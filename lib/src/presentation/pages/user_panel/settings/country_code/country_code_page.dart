import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../features/user/application/user_info_providers.dart';
import '../../../../../features/user/domain/entity/user_entity.dart';

class CountryCodePage extends StatelessWidget {
  const CountryCodePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedCountryCode;
    String? selectedDialCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).countryCode),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              AppLocalizations.of(context).selectYourCountryCode,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: CountryCodePicker(
              dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onChanged: (countryCode) {
                selectedCountryCode = countryCode.code ?? selectedCountryCode;
                selectedDialCode = countryCode.dialCode ?? selectedDialCode;
              },
              showDropDownButton: true,
              initialSelection:
                  context.read(userInfoNotifierProvider).user!.countryCode ??
                      'US',
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              AppLocalizations.of(context).defaultCountryCodeMessage,
              style: const TextStyle(fontSize: 15.0),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //TODO save function
                  final UserEntity currentUser =
                      context.read(userInfoNotifierProvider).user!;
                  final newUserInfo = currentUser.copyWith(
                    countryCode: selectedDialCode,
                    dialCode: selectedDialCode,
                  );
                  context
                      .read(userInfoNotifierProvider)
                      .updateUserInfo(newUserInfo);
                  AutoRouter.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context).save,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
