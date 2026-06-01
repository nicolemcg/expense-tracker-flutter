import 'package:expense_tracker/models/expense_transaction.dart';
import 'package:flutter/foundation.dart';
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
  String selectedCategory = "Food";
  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    "Food",
    "Transport",
    "Health",
    "Entertainment",
    "Shopping",
    "Salary",
    "Other",
  ];

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
          category: selectedCategory,
          date: selectedDate,
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

            DropdownButtonFormField<String>(
              value: selectedCategory, 
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Category",
              ),
              items: categories.map((category){
                return DropdownMenuItem(
                  value: category,
                  child: Text(category)
                );
              }).toList(),
              onChanged: (value){
                setState(() {
                  selectedCategory = value!;
                });
              }
            ),

            const SizedBox(height: 16),

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

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );

                    if(pickedDate != null){
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  }, 
                  child: const Text("Select Date"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: validateSave, 
              child: const Text("Save")
            ),
          ],
        ),
      )
    );
  }
}