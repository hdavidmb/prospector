import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../../generated/l10n.dart';

class PhonesTextFields extends StatefulWidget {
  final List<String> initialPhonesList;
  final String formPhone;
  final String formWhatsapp;
  final void Function(List<String>) onPhonesListChanged;
  final void Function(String) onPhoneChanged;
  final void Function(String) onWhatsappChanged;
  const PhonesTextFields({
    Key? key,
    required this.initialPhonesList,
    required this.formPhone,
    required this.formWhatsapp,
    required this.onPhonesListChanged,
    required this.onPhoneChanged,
    required this.onWhatsappChanged,
  }) : super(key: key);

  @override
  _PhonesTextFieldsState createState() => _PhonesTextFieldsState();
}

class _PhonesTextFieldsState extends State<PhonesTextFields> {
  final List<String> phonesList = [];
  final List<Widget> textFields = [];
  final List<int> hidenIndexes = [];

  void addTextField({
    required int index,
    String? initialValue,
  }) {
    textFields.add(
      // TODO extract row as widget taking index as parameter and use it to add new rows
      TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone),
          hintText: index == 0
              ? AppLocalizations.of(context).phone
              : AppLocalizations.of(context).newPhone,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
          ),
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            // Remove current textfield, controller and phone
            FocusScope.of(context).unfocus();
            if (phonesList[index] == widget.formPhone) {
              final String newPhone = phonesList.firstWhere(
                  (phone) => phone.isNotEmpty && phone != phonesList[index],
                  orElse: () => value);
              widget.onPhoneChanged(newPhone);
            }
            if (phonesList[index] == widget.formWhatsapp) {
              final String newWhatsapp = phonesList.firstWhere(
                  (phone) => phone.isNotEmpty && phone != phonesList[index],
                  orElse: () => value);
              widget.onWhatsappChanged(newWhatsapp);
            }
            phonesList[index] = value;
            setState(() {
              hidenIndexes.add(index);
            });
          } else {
            if (index == phonesList.length) {
              // Is last textField - add new textField and controller
              if (phonesList.where((phone) => phone.isNotEmpty).isEmpty) {
                // Is first phone added
                widget.onPhoneChanged(value);
                widget.onWhatsappChanged(value);
              }
              phonesList.add(value);

              // Add new controller and textfield
              addTextField(
                index: index + 1,
              );
            } else {
              if (phonesList[index] == widget.formPhone) {
                widget.onPhoneChanged(value);
              }
              if (phonesList[index] == widget.formWhatsapp) {
                widget.onWhatsappChanged(value);
              }
              phonesList[index] = value;
            }
          }
          widget.onPhonesListChanged(
              phonesList.where((phone) => phone.isNotEmpty).toList());
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      phonesList.addAll(widget.initialPhonesList);

      for (int index = 0; index <= phonesList.length; index++) {
        // Create controller and textfield row
        addTextField(
          index: index,
          initialValue: index < phonesList.length ? phonesList[index] : '',
        );
      }
      setState(() {});
    });
  }

  //TODO check for whatsapp and phone conflict with duplicate numbers
// TODO check when pone is deleted losses phone and whatsapp selectors. Implement logic to asign lost selector to the first phone left
  @override
  Widget build(BuildContext context) {
    // Arrange textefields and buttons to show on a column
    final List<Widget> children = [];
    for (int i = 0; i < textFields.length; i++) {
      if (!hidenIndexes.contains(i)) {
        children.add(
          Row(
            children: [
              Expanded(child: textFields[i]),
              PhoneWhatsappButton(
                index: i,
                isWhatsapp: false,
                isSelected:
                    i < phonesList.length && phonesList[i] == widget.formPhone,
                onPressed: () {
                  if (i < phonesList.length) {
                    widget.onPhoneChanged(phonesList[i]);
                  }
                },
              ),
              PhoneWhatsappButton(
                index: i,
                isSelected: i < phonesList.length &&
                    phonesList[i] == widget.formWhatsapp,
                isWhatsapp: true,
                onPressed: () {
                  if (i < phonesList.length) {
                    widget.onWhatsappChanged(phonesList[i]);
                  }
                },
              ),
            ],
          ),
        );
        if (i < phonesList.length) {
          children.add(const Divider(height: 0.0));
        }
      } else {
        children.add(const SizedBox());
      }
    }

    return Column(children: children);
  }
}

class PhoneWhatsappButton extends StatelessWidget {
  const PhoneWhatsappButton({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.isWhatsapp,
    required this.onPressed,
  }) : super(key: key);

  final int index;
  final bool isSelected;
  final bool isWhatsapp;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDarkMode ? Colors.white12 : Colors.black12;
    final selectedColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        borderRadius: isWhatsapp
            ? const BorderRadius.only(
                topRight: Radius.circular(4.0),
                bottomRight: Radius.circular(4.0),
              )
            : null,
        color: Theme.of(context).inputDecorationTheme.fillColor,
      ),
      child: IconButton(
        icon: Icon(
          isWhatsapp ? FontAwesomeIcons.whatsapp : Icons.phone_in_talk_rounded,
          color: isSelected ? selectedColor : unselectedColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
