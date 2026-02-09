import 'package:expense_tracker_self/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.expense,

  });

  final ExpenseModel expense;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin:EdgeInsets.symmetric(horizontal: 0, vertical: 4), //converted the default horizontal spacing of the card to zero.
      child: ListTile(
        title: Text(expense.title),
        subtitle: Text(expense.amount.toString()),
        trailing: Text(expense.formattedDate),
      ),
    );
  }
}