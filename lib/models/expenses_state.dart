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

  /// Removes any given item from the cart.
  void addExpense(Expense expense) {
    _expenses.add(expense);

    print("new expense added");
    print('Number of items in list ${_expenses.length.toString()}');
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void undoDeleteExpense(
    int index,
    Expense expense,
  ) {
    _expenses.insert(index, expense);

    print("Expense deletion undid");
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

  //***IGNORE BELOW ***/

  // UnmodifiableListView<Category> get categories =>
  //     UnmodifiableListView(_categories);
  // final List<Category> _categories = Category.values;

//   void getCategories() {
// for (final category in categories) {
//       expenses.where((item) => item.category == category).toList();
//       print('The category is $category');
//     }

//   }

  double getCategoryExpense(category) {
    double sum = 0;

    List<Expense> exps;

    print(category);

    //var formatter = NumberFormat('#,###,000.00');
    exps = expenses.where((item) => item.category == category).toList();

    for (final exp in exps) {
      sum += exp.amount;
    }
    print(sum);
    return sum;
  }
}
