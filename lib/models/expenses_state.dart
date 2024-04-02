import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:travel_expenses/models/expense.dart';

class ExpensesState extends ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
      title: 'Valentine Dinner',
      amount: 250,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Sky Diving',
      amount: 500.00,
      date: DateTime.now(),
      category: Category.experience,
    ),
  ];

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  UnmodifiableListView<Expense> get expenses => UnmodifiableListView(_expenses);

  /// Removes all items from the cart.
  void addExpense(Expense expense) {
    _expenses.add(expense);

    print("new expense added");
    print('Number of items in list ${_expenses.length.toString()}');
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeExpense(id) {
    _expenses.removeWhere((item) => item.id == id);

    print('Number of items in list ${_expenses.length.toString()}');
    print('Expense with id $id removed');
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
