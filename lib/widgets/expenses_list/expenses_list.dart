import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expenses, required this.onRemoveExpense});
  Function onRemoveExpense;
  List<Expense> expenses;
  @override
  Widget build(BuildContext context) {
    //column: All child widgets are rendered at once
    //listView: only renders the visible items and a few offscreen items. Thus, it is more efficient with large number of items
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: ValueKey(expenses[index]),
              onDismissed: (direction) => onRemoveExpense(expenses[index]),
              child: ExpenseItem(expense: expenses[index]));
          //Often used for swipe-to-dismiss functionality, like deleting an item from a list.
        });
  }
}
