import 'package:flutter/material.dart';
import './../models/expense_transaction.dart';

class ReportScreen extends StatelessWidget {

  final List<ExpenseTransaction> transactions;

  const ReportScreen({
    super.key,
    required this.transactions,
  });


  @override
  Widget build(BuildContext context) {

    double totalIncome = 0;
    double totalExpenses = 0;

    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
        categoryTotals.update(
          transaction.category,
          (value) => value + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }

    double balance = totalIncome - totalExpenses;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Financial Summary",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  ListTile(
                    title: const Text("Total Income"),
                    trailing: Text(
                      "${totalIncome.toStringAsFixed(2)}",
                    ),
                  ),

                  ListTile(
                    title: const Text("Total Expenses"),
                    trailing: Text(
                      "${totalExpenses.toStringAsFixed(2)}",
                    ),
                  ),

                  ListTile(
                    title: const Text("Balance"),
                    trailing: Text(
                      "${balance.toStringAsFixed(2)}",
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Expenses by Category",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: categoryTotals.isEmpty
                ? const Center(
                    child: Text(
                      "No expense data available",
                    ),
                  )
                : ListView(
                    children: categoryTotals.entries.map((entry) {

                      return Card(
                        child: ListTile(
                          title: Text(entry.key),
                          trailing: Text(
                            "${entry.value.toStringAsFixed(2)}",
                          ),
                        ),
                      );

                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}