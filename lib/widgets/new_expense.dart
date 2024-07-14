import 'package:flutter/material.dart';
import 'package:third_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  NewExpense({required this.onAddExpense, super.key});
  Function onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final costController = TextEditingController();
  Category selectedCategory = Category.leisure;
  //TextEditingController is a Flutter class that allows you to control the text being edited in a text field widge
  DateTime? selectedDate;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
    // ).then((value){

    // });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(costController.text);
    bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // Add 'return' here
            title: Text('Invalid input'),
            content: Text('Please make sure you entered all required data'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Okay'),
              )
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: titleController.text,
          amount: enteredAmount,
          date: selectedDate!,
          category: selectedCategory),
    );
    Navigator.pop(context);
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
      padding: EdgeInsets.fromLTRB(16, 60, 16, 16),
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
                    Text(selectedDate == null
                        ? 'No date selected'
                        : formatter.format(selectedDate!)),
                    IconButton(
                        onPressed: presentDatePicker,
                        icon: Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: selectedCategory,
                  //The value property is set to selectedCategory, which is the currently selected item in the dropdown.
                  items: Category.values
                      //Category.values returns a list of all possible values for the Category enum.
                      .map(
                        //map((category) { ... }) iterates over each category in Category.values and transforms each into a DropdownMenuItem.
                        (category) => DropdownMenuItem(
                          value: category,
                          //value: category,: Sets the value of the dropdown menu item to the current category in the iteration.
                          child: Text(
                            category.name.toUpperCase(),
                          ),
                          //child: Text(category.name.toUpperCase()),: Sets the display text of the dropdown menu item to the name of the category in uppercase.
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null)
                        return;
                      else
                        selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //removes the overlay from the screen
                  },
                  child: Text('Cancel')),
              ElevatedButton(
                  onPressed: submitExpenseData, child: Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
