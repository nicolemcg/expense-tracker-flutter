import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {

  final Function(ExpenseTransaction) onAddTransaction;

  const AddScreen({
      super.key,
      required this.onAddTransaction,
    });

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String transactionType = "Expense";

  void validateSave(){
    if (_formKey.currentState!.validate()) {
      print(descriptionController.text);
      print(amountController.text);
      print(transactionType);

      if (_formKey.currentState!.validate()) {

        ExpenseTransaction transaction = ExpenseTransaction(
          description: descriptionController.text,
          amount: double.parse(amountController.text),
          isIncome: transactionType == "Income",
        );

        widget.onAddTransaction(transaction);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter a description";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter an amount";
                }
                if(double.tryParse(value) == null){
                  return "Enter a valid number";
                }
                return null;
              }
            ),

            const SizedBox(height: 16),
            
            DropdownButtonFormField(
              value: transactionType,
              items: const [
                DropdownMenuItem(
                  value: "Income",
                  child: Text("Income"),
                ),
                DropdownMenuItem(
                  value: "Expense",
                  child: Text("Expense") 
                ),
              ], 
              onChanged: (value){
                setState(() {
                  transactionType = value!;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: validateSave, 
              child: const Text("Save")
            )
          ],
        ),
      )
    );
  }
}