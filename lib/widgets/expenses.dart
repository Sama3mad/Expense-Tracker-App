import 'package:flutter/material.dart';
import 'package:third_app/widgets/expenses_list/expenses_list.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> registeredExpenses = [
    Expense(
        title: 'flutter course',
        amount: 99.9,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema date',
        amount: 150,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void openOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewExpense();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses App'),
        actions: [
          IconButton(onPressed: openOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Text('Chart here'),
          Expanded(child: ExpensesList(expenses: registeredExpenses)),
          //If you don't wrap the ListView with Expanded, the ListView will have infinite height
          //constraints because the column gives the maximum possible width but unconstrained height.
        ],
      ),
    );
  }
}
