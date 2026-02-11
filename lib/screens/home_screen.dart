import 'package:expense_tracker_self/models/expense_model.dart';
import 'package:expense_tracker_self/widgets/add_expense_sheet.dart';
import 'package:expense_tracker_self/widgets/chart.dart';
import 'package:expense_tracker_self/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: "Flutter Course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Bangalore",
      amount: 15,
      date: DateTime.now(),
      category: Category.travel,
    ),
    ExpenseModel(
      title: "Biriyani",
      amount: 10,
      date: DateTime.now(),
      category: Category.food,
    ),
    ExpenseModel(
      title: "Beach",
      amount: 5,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _addedExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses = [..._registeredExpenses, expense];
    });
  }

  void _removeExpense(ExpenseModel removedExpense) {
    final expenseIndex = _registeredExpenses.indexOf(removedExpense);
    setState(() {
      _registeredExpenses.remove(removedExpense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, removedExpense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Center(
      child: Text(
        "No expenses found. Start adding some!",
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: _registeredExpenses.length,
        itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withValues(
              //we have overriden and customed color scheme in main.dart
              alpha: 0.2, // light background
              red: 0.9, // slightly less intense red
              green: 0.3, // add a touch of orange
              blue: 0.3,
            ),
          ),
          key: ValueKey(_registeredExpenses[index].id),
          onDismissed: (direction) =>
              _removeExpense(_registeredExpenses[index]),
          child: ExpenseCard(expense: _registeredExpenses[index]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                
                constraints: BoxConstraints.expand(),
                context: context,
                builder: (ctx) {
                  return AddExpenseSheet(addExpense: _addedExpense);
                },
              );
            },
            //hoverColor: Colors.blue,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  const SizedBox(width: 10),
                  Expanded(child: mainContent),
                ],
              ),
      ),
    );
  }
}
