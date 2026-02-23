
import 'package:expense_tracker_self/models/expense_model.dart';

List<ExpenseModel> registeredExpenses = [
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