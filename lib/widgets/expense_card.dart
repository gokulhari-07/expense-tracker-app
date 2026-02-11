import 'package:expense_tracker_self/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.expense});

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final detailsColor = isDarkMode ? Colors.black : null;
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 4,
      ), //converted the default horizontal spacing of the card to zero.
      child: ListTile(
        title: Text(
          expense.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text("₹ ${expense.amount.toStringAsFixed(2)}", style:TextStyle(color:detailsColor)),
        trailing:
            //Text(expense.formattedDate),
            Row(
              mainAxisSize: MainAxisSize
                  .min, //Row defaults to mainAxisSize: MainAxisSize.max. In trailing, that makes the Row try to take all horizontal space, which causes ListTile layout assertions/overflow, so the tile can fail to render (looks like it disappeared). Thats why using a minimal width row.
              children: [
                Icon(categoryIcons[expense.category]),
                const SizedBox(width: 5),
                Text(expense.formattedDate, style:TextStyle(color: detailsColor)),
              ],
            ),
      ),
    );
  }
}
