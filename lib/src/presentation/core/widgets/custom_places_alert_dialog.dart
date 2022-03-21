import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../generated/l10n.dart';
import '../../../core/private/private_keys.dart';

class CustomPlacesAlertDialog extends StatefulWidget {
  const CustomPlacesAlertDialog({
    Key? key,
  }) : super(key: key);

  @override
  _CustomPlacesAlertDialogState createState() =>
      _CustomPlacesAlertDialogState();
}

class _CustomPlacesAlertDialogState extends State<CustomPlacesAlertDialog> {
  Timer? _throttle;

  List<String> filteredPlacesList = [];
  final _formKey = GlobalKey<FormState>();
  final kGoogleApiKey = PrivateKeys.getGooglePlacesApiKey();
  final String baseURL =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              AutoRouter.of(context).pop();
            },
            icon: Platform.isIOS
                ? const Icon(Icons.arrow_back_ios)
                : const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: AppLocalizations.current.typeLocation,
                ),
                onFieldSubmitted: (value) {
                  if (_throttle?.isActive ?? false) _throttle?.cancel();
                  AutoRouter.of(context).pop(value);
                },
                onChanged: (value) {
                  if (_throttle?.isActive ?? false) _throttle?.cancel();
                  if (value != '') {
                    _throttle = Timer(
                      const Duration(milliseconds: 200),
                      () async {
                        final Uri request = Uri.parse(
                            '$baseURL?input=$value&key=$kGoogleApiKey');
                        final http.Response response = await http.get(request);
                        final Map<String, dynamic>? responseJSON =
                            json.decode(response.body) as Map<String, dynamic>?;
                        final List? predictions =
                            responseJSON?['predictions'] as List?;
                        if (mounted) {
                          setState(() {
                            filteredPlacesList = predictions != null
                                ? predictions
                                    .map((p) => (p
                                        as Map<String, String>)['description']!)
                                    .toList()
                                : [];
                          });
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      content: (filteredPlacesList.isEmpty)
          ? Text(
              AppLocalizations.current.customPlacesMessage,
              textAlign: TextAlign.center,
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0.0,
                    indent: 8.0,
                  );
                },
                shrinkWrap: true,
                itemCount: filteredPlacesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(filteredPlacesList[index]),
                    onTap: () {
                      AutoRouter.of(context).pop(filteredPlacesList[index]);
                    },
                  );
                },
              ),
            ),
      titlePadding: EdgeInsets.zero,
      contentPadding: filteredPlacesList.isEmpty
          ? const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0)
          : EdgeInsets.zero,
    );
  }
}
