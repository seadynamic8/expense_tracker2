import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category { leisure, work, travel, food }

const categoryIcons = {
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff,
  Category.food: Icons.lunch_dining,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category});

  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
