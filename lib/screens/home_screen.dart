import 'package:expense_tracker_self/models/expense_model.dart';
import 'package:expense_tracker_self/widgets/add_expense_sheet.dart';
import 'package:expense_tracker_self/widgets/expense_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(title: "Flutter Course", amount: 19.99, date: DateTime.now()),
    ExpenseModel(title: "Python Course", amount: 25.5, date: DateTime.now()),
  ];

  void _addedExpense(ExpenseModel expense) {
    setState(() {
      _registeredExpenses = [..._registeredExpenses, expense];
    });
  }

  void _removeExpense(ExpenseModel removedExpense){
    setState(() {
      _registeredExpenses.remove(removedExpense);
    });
    
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent=const Center(child: Text("No expenses found. Start adding some!"));

    if(_registeredExpenses.isNotEmpty){
      mainContent = ListView.builder(
        itemCount: _registeredExpenses.length,
        itemBuilder: (context, index) =>
            Dismissible(
              key:ValueKey(_registeredExpenses[index].id),
              onDismissed: (direction) => _removeExpense(_registeredExpenses[index]),
              child: ExpenseCard(expense: _registeredExpenses[index]),),
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
                useSafeArea: true,
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
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: Column(
          children: [
            Chart(),
            Expanded(child: mainContent),
          ],
        ),
      ),
      
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:16),
      child: Container(
        height:200,
        decoration: BoxDecoration(
           gradient: LinearGradient(
            colors: [Colors.black, const Color.fromARGB(255, 35, 92, 139)],
            begin:Alignment.topCenter,
            end:Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}


