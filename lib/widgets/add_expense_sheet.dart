import 'package:expense_tracker_self/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Category { food, travel, leisure, work }

class AddExpenseSheet extends StatefulWidget {
  const AddExpenseSheet({super.key, required this.addExpense});

  final void Function(ExpenseModel expense) addExpense;

  @override
  State<AddExpenseSheet> createState() {
    return _AddExpenseSheetState();
  }
}

class _AddExpenseSheetState extends State<AddExpenseSheet> {
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isDateInvalid = false;

  void _openDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
      _isDateInvalid = false; //reset error
    });
  }

  void _submitExpense() {
    final isValid = _formKey.currentState!.validate();

    setState(() {
      _isDateInvalid = _selectedDate == null;
    });

    if (!isValid || _selectedDate == null) {
      return;
    }

    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.parse(_amountController.text);

    widget.addExpense(
      ExpenseModel(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title cannot be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(label: Text("Title")),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*$'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Amount cannot be empty";
                        }

                        // Prevent values like ".", "12."
                        if (value.endsWith('.')) {
                          return "Enter a valid decimal number";
                        }

                        final amount = double.tryParse(value);
                        if (amount == null || amount <= 0) {
                          return "Amount must be a digit greater than 0";
                        }

                        return null;
                      },
                      decoration: InputDecoration(label: Text("Amount")),
                    ),
                  ),
                  //const SizedBox(width: 5),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _openDatePicker,
                    label: _selectedDate == null
                        ? Text(
                            "No date selected",
                            style: TextStyle(
                              color: _isDateInvalid ? Colors.red : null,
                            ),
                          )
                        : Text(
                            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                          ),
                    icon: Icon(Icons.calendar_month_outlined, color: _isDateInvalid? Colors.red:null),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  DropdownButton(
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value:
                                category, //If DropdownButton has a value, every DropdownMenuItem MUST have a matching value. Otherwise red error screen shows.
                            child: Text(category.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _selectedCategory = value;
                        }
                      });
                    },
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpense,
                    child: Text("Save Expense"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
