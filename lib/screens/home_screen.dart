import 'package:flutter/material.dart';
import './../models/expense_transaction.dart';

class HomeScreen extends StatelessWidget {

  final List<ExpenseTransaction> transactions;

  const HomeScreen({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {

    double totalIncome = 0;
    double totalExpenses = 0;

    for(var transaction in transactions){
      if(transaction.isIncome){
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
      }
    }
    double balance = totalIncome - totalExpenses;
    
    return Column(
      children: [
        //sumary card
        Card(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Current Balance",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              Text(
                "\$${balance.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text("Income"),
                      Text(
                        "\$${totalIncome.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Expenses"),
                      Text(
                        "\$${totalExpenses.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ),

        //transations list
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index){

              final transaction =  transactions[index];
              
              return ListTile(
                title: Text(transaction.description),

                subtitle: Text(
                  "${transaction.category} • "
                  "${transaction.isIncome ? 'Income' : 'Expense'} • "
                  "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                ),

                trailing: Text(
                  transaction.isIncome ?
                  "+${transaction.amount}" : "-${transaction.amount}",
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}