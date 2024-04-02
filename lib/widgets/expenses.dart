import 'package:flutter/material.dart';
import 'package:travel_expenses/models/expenses_state.dart';
import 'package:travel_expenses/widgets/expense_chart.dart';
import 'package:travel_expenses/widgets/expenses_list/expense_list.dart';
import 'package:travel_expenses/models/expense.dart';
import 'package:travel_expenses/widgets/new_expense.dart';
import 'package:provider/provider.dart';

class Expenses extends StatefulWidget {
  const Expenses();

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  void _openAddExpenseItemOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (modalContext) => const NewExpense(),
      backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
    );
  }

  @override
  Widget build(context) {
    var state = Provider.of<ExpensesState>(context);

    void _removeExpense(Expense expense) {
      state.removeExpense(expense.id);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense Deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              state.addExpense(expense);
            }),
      ));
    }

    Widget mainScreenContent = const Center(
      child: Text(' No Expenses here.. Please add some'),
    );

    if (state.expenses.isNotEmpty) {
      mainScreenContent = ExpensesList(
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Expenses Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseItemOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: state.expenses),
          Expanded(child: mainScreenContent)
        ],
      ),
    );
  }
}
