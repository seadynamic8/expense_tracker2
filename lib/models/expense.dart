import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
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

class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(
      {required List<Expense> allExpenses, required this.category})
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  // double get totalExpenses {
  //   return expenses.fold(0.0, (total, expense) => total + expense.amount);
  // }

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
