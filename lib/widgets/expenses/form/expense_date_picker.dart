import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class ExpenseDatePicker extends StatefulWidget {
  const ExpenseDatePicker({
    super.key,
    required this.selectDate,
  });

  final void Function(DateTime?) selectDate;

  @override
  State<ExpenseDatePicker> createState() => _ExpenseDatePickerState();
}

class _ExpenseDatePickerState extends State<ExpenseDatePicker> {
  DateTime? _selectedDate;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
    widget.selectDate(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(_selectedDate == null
            ? 'No date selected'
            : formatter.format(_selectedDate!)),
        IconButton(
          onPressed: () => _showDatePicker(),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
