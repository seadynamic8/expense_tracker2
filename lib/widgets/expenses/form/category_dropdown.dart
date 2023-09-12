import 'package:flutter/material.dart';

import 'package:expense_tracker2/models/expense.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    super.key,
    required this.selectedCategory,
    required this.selectCategory,
  });

  final Category selectedCategory;
  final void Function(Category) selectCategory;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  Category? _selectedCategory;

  @override
  void initState() {
    _selectedCategory = widget.selectedCategory;
    super.initState();
  }

  void _changeCategory(value) {
    if (value == null) return;

    setState(() {
      _selectedCategory = value;
    });

    widget.selectCategory(_selectedCategory!);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: _changeCategory,
    );
  }
}
