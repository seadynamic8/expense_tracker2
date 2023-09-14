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
    final themeColorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

    final buckets = getBuckets();
    final maxTotalExpense = getMaxTotalExpense(buckets);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      width: double.infinity,
      height: width < 600 ? 180 : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            themeColorScheme.primary.withOpacity(0.3),
            themeColorScheme.primary.withOpacity(0.0),
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
                          color: isDarkMode
                              ? themeColorScheme.secondary
                              : themeColorScheme.primary.withOpacity(0.7),
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
