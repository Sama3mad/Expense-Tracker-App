import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expense, super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            SizedBox(height: 4),
            Row(
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                //\$ to output a dollar sign
                //the diff. between toStringAsFixed(2) and toString is that it will limit the number to two dec places 2.333 -> 2.33
                Spacer(),
                // It expands to fill the available space along its main axis (either horizontally in a Row or vertically in a Column),
                // pushing adjacent widgets to either end.
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
