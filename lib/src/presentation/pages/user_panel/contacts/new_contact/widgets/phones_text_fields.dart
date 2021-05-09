import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PhonesTextFields extends StatefulWidget {
  final List<String> phonesList;
  final String phone;
  final String whatsapp;
  final void Function(List<String>) onPhonesListChanged;
  final void Function(String) onPhoneChanged;
  final void Function(String) onWhatsappChanged;
  const PhonesTextFields({
    Key? key,
    required this.phonesList,
    required this.phone,
    required this.whatsapp,
    required this.onPhonesListChanged,
    required this.onPhoneChanged,
    required this.onWhatsappChanged,
  }) : super(key: key);

  @override
  _PhonesTextFieldsState createState() => _PhonesTextFieldsState();
}

class _PhonesTextFieldsState extends State<PhonesTextFields> {
  final List<TextEditingController> controllers = [];
  final List<TextEditingController> removedControllers = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> textFields = [];
    for (int index = 0; index <= widget.phonesList.length; index++) {
      if (index == controllers.length) {
        controllers.add(
          TextEditingController(
              text: widget.phonesList.isNotEmpty &&
                      index < widget.phonesList.length
                  ? widget.phonesList[index]
                  : ''),
        );
      }
      textFields.add(
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controllers[index],
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  hintText: index == 0
                      ? AppLocalizations.of(context)!.phone
                      : AppLocalizations.of(context)!.newPhone,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).unfocus();
                    removedControllers.add(controllers[index]);
                    controllers.removeAt(index);
                    removedControllers.add(controllers.last);
                    controllers.removeLast();
                    widget.phonesList.removeAt(index);
                  } else {
                    if (index == widget.phonesList.length) {
                      if (index == 0) {
                        widget.onPhoneChanged(value);
                        widget.onWhatsappChanged(value);
                      }
                      widget.phonesList.add(value);
                    } else {
                      if (widget.phonesList[index] == widget.phone) widget.onPhoneChanged(value);
                      if (widget.phonesList[index] == widget.whatsapp) widget.onWhatsappChanged(value);
                      widget.phonesList[index] = value;
                    }
                    widget.onPhonesListChanged(widget.phonesList);
                  }
                },
              ),
            ),
            Container(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              child: IconButton(
                icon: Icon(
                  Icons.phone_in_talk_rounded,
                  color: _getPhoneIconColor(context, index, widget.phone),
                ),
                onPressed: () {
                  if (index < widget.phonesList.length) {
                    widget.onPhoneChanged(widget.phonesList[index]);
                  }
                },
              ),
            ),
            Container(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: _getPhoneIconColor(context, index, widget.whatsapp),
                ),
                onPressed: () {
                  if (index < widget.phonesList.length) {
                    widget.onWhatsappChanged(widget.phonesList[index]);
                  }
                },
              ),
            ),
          ],
        ),
      );
      if (index < widget.phonesList.length) textFields.add(const Divider(height: 0.0));
    }
    return Column(children: textFields);
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    for (final controller in controllers) {
      controller.dispose();
    }
    for (final controller in removedControllers) {
      controller.dispose();
    }
  }

  Color _getPhoneIconColor(BuildContext context, int index, String toCompare) {
    final brightness = Theme.of(context).brightness;
    final disabledColor =
        brightness == Brightness.dark ? Colors.white12 : Colors.black12;
    final selectedColor = brightness == Brightness.dark ? Colors.white70 : Colors.black87;
    if (index < widget.phonesList.length) {
      return (toCompare == widget.phonesList[index])
          ? selectedColor
          : disabledColor;
    } else {
      return disabledColor;
    }
  }
}
