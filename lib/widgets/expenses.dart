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
      isScrollControlled: true,
      //This property allows the modal to take up the full height of the screen if needed.
      context: context,
      builder: (context) {
        return NewExpense(onAddExpense: addExpense);
      },
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    //ScaffoldMessenger.of(context).clearSnackBars(); is a method call in Flutter that clears all currently displayed snack bars from the ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Expense Deleted'),
        duration: Duration(seconds: 10),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No Expenses. Try add some'),
    );

    if (registeredExpenses.isNotEmpty)
      mainContent = ExpensesList(
        expenses: registeredExpenses,
        onRemoveExpense: removeExpense,
      );
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
          Expanded(child: mainContent),
          //If you don't wrap the ListView with Expanded, the ListView will have infinite height
          //constraints because the column gives the maximum possible width but unconstrained height.
        ],
      ),
    );
  }
}
