
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final formatter=DateFormat.yMd();

class ExpenseModel {
   ExpenseModel({required this.title, required this.amount, required this.date}):id=UniqueKey().toString();
 //Why prfomrance is not affected if we dont use const for the above constructor due to dyamic id?
 // ✅ Reality (very important)
// For model/data classes, const provides almost zero real-world performance benefit.
// Why?
// ExpenseModel is not a widget
// It’s not rebuilt in the widget tree
// It’s just a plain Dart object
// It’s created only when:
// Adding an expense
// App starts (mock data)
// ➡️ This happens very rarely, not every frame.

// 💡 Where const REALLY matters
// const is critical for:
// Widgets
// Build methods
// Hot rebuild performance
// Reducing widget tree rebuild cost

// 3️⃣ Real production apps do this ALL the time

// Let me be very clear:
// 99% of production Flutter apps do NOT use const constructors for model classes.
// Why?
// Models often have:
// IDs
// UUIDs
// timestamps
// database keys
// server-generated values

// All of these break const.
// And that’s normal.
//Summary: const is a widget optimization tool, not a data-model requirement.

  final String title;
  final double amount;
  final DateTime date;
  final String id;

  String get formattedDate { //Getters are basically "computed properties" => Properties that are
  // dynamically derived, based on other class properties. Here the type of the getter we have given is 
  //String, so the getter should return a String value.
  return formatter.format(date);
  }

}