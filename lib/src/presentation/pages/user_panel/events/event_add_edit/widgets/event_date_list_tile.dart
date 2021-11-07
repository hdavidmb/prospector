import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../helpers/date_formatters.dart';
import '../../../../../theme/theme_providers.dart';
import '../../events_constants.dart';

class EventDateListTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final DateTime? firstDate;
  final void Function(DateTime value) onDateSelected;
  const EventDateListTile({
    Key? key,
    required this.title,
    required this.date,
    this.firstDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final is24hours = context.read(themeNotifierProvider).is24hours;
    return ListTile(
      title: Row(
        children: [
          Text(title),
          const Expanded(child: SizedBox()),
          PickerCell(
            title: dateCellFormattedDate(date: date),
            date: date,
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: firstDate ?? kFirstDate,
                lastDate: kLastDate,
              );
              if (pickedDate != null) {
                final DateTime savingDate = DateTime(pickedDate.year,
                    pickedDate.month, pickedDate.day, date.hour, date.minute);
                onDateSelected(savingDate);
              }
            },
          ),
          PickerCell(
            title: formattedTime(is24hours: is24hours, date: date),
            date: date,
            onTap: () async {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(date),
                builder: (context, child) {
                  final mediaQueryWrapper = MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: is24hours),
                    child: child!,
                  );
                  if (Localizations.localeOf(context).languageCode == 'es') {
                    return Localizations.override(
                      context: context,
                      locale: const Locale('es', 'US'),
                      child: mediaQueryWrapper,
                    );
                  }
                  return mediaQueryWrapper;
                },
              );
              if (pickedTime != null) {
                final DateTime savingDate = DateTime(date.year, date.month,
                    date.day, pickedTime.hour, pickedTime.minute);
                onDateSelected(savingDate);
              }
            },
          )
        ],
      ),
    );
  }
}

class PickerCell extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final DateTime date;
  const PickerCell({
    Key? key,
    required this.title,
    required this.onTap,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
            color: isDarkMode ? Colors.white24 : Colors.black12,
            borderRadius: const BorderRadius.all(Radius.circular(6.0))),
        child: Text(title),
      ),
    );
  }
}
