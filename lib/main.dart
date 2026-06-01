import 'package:expense_tracker/database/database_helper.dart';
import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:expense_tracker/screens/add_screen.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/report_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp (const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  
  List<ExpenseTransaction> transactions = [];

  void addTransaction(ExpenseTransaction transaction){
    setState(() {
      transactions.add(transaction);
    });
  }

  void deleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   loadTransactions();
  // }
  // Future<void> loadTransactions() async {
  //   final data = await DatabaseHelper.instance.getTransactions();

  //   setState(() {
  //     transactions = data;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    
    final pages = [
      HomeScreen(
        transactions: transactions,
        onDeleteTransaction: deleteTransaction,
      ),
      AddScreen(
        onAddTransaction: addTransaction,
      ),
      ReportScreen(
        transactions: transactions,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Report",
          ),
        ]
      ),
    );
  }
}