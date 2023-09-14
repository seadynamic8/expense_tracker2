import 'package:flutter/material.dart';

import 'package:expense_tracker2/models/expense.dart';
import 'package:expense_tracker2/widgets/expenses/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> getBuckets() {
    return Category.values
        .map((category) => ExpenseBucket.forCategory(
            allExpenses: expenses, category: category))
        .toList();
  }

  double getMaxTotalExpense(List<ExpenseBucket> buckets) {
    return buckets.fold(0.0, (maxTotal, bucket) {
      double totalExpenses = bucket.totalExpenses;
      return totalExpenses > maxTotal ? totalExpenses : maxTotal;
    });
  }

  double expenseRatio(ExpenseBucket bucket, double maxTotalExpense) {
    double totalExpenses = bucket.totalExpenses;
    return totalExpenses == 0 ? 0 : totalExpenses / maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final buckets = getBuckets();
    final maxTotalExpense = getMaxTotalExpense(buckets);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map((bucket) =>
                      ChartBar(fill: expenseRatio(bucket, maxTotalExpense)))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets
                .map((bucket) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          categoryIcons[bucket.category],
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}