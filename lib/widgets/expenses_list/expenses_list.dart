import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expenses});

  List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    //column: All child widgets are rendered at once
    //listView: only renders the visible items and a few offscreen items. Thus, it is more efficient with large number of items
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return ExpenseItem(expense: expenses[index]);
        });
  }
}
