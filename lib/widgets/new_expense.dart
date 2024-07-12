import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final costController = TextEditingController();
  //TextEditingController is a Flutter class that allows you to control the text being edited in a text field widge

  void presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    costController.dispose();
    super.dispose();
  }
  //This is important to prevent memory leaks when the widget using titlleController is no longer needed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            //max number of characters
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: costController,
                  maxLength: 100,
                  //max number of characters
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Selected data'),
                    IconButton(
                        onPressed: presentDatePicker,
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(titleController.text);
                    print(costController.text);
                  },
                  child: Text('Save Expense')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //removes the overlay from the screen
                  },
                  child: Text('Cancel')),
            ],
          )
        ],
      ),
    );
  }
}
