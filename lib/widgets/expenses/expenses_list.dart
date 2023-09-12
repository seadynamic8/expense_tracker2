import 'package:flutter/material.dart';

import 'package:expense_tracker2/models/expense.dart';
import 'package:expense_tracker2/widgets/expenses/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;

  void removeExpense(Expense expense) {
    onRemoveExpense(expense);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          decoration: const BoxDecoration(
            color: Colors.purple,
          ),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => removeExpense(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
