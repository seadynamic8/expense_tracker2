import 'package:flutter/material.dart';

import 'package:expense_tracker2/models/expense.dart';
import 'package:expense_tracker2/widgets/expenses/form/expense_date_picker.dart';
import 'package:expense_tracker2/widgets/expenses/form/amount_field.dart';
import 'package:expense_tracker2/widgets/expenses/form/category_dropdown.dart';
import 'package:expense_tracker2/widgets/expenses/form/title_field.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _selectDate(pickedDate) {
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _selectCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text.trim());
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;

    // Validation
    if (enteredTitle.isEmpty || isAmountInvalid || _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.addExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text(
            'Please make sure the title, amount, date, and category are correct.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
      child: Column(
        children: [
          TitleField(titleController: _titleController),
          Row(
            children: [
              Expanded(
                child: AmountField(amountController: _amountController),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: ExpenseDatePicker(selectDate: _selectDate),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              CategoryDropdown(
                  selectedCategory: _selectedCategory,
                  selectCategory: _selectCategory),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
