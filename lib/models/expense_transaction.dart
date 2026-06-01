class ExpenseTransaction {
  String description;
  double amount;
  bool isIncome;
  String category;
  DateTime date;

  ExpenseTransaction({
    required this.description,
    required this.amount,
    required this.isIncome,
    required this.category,
    required this.date,
  });
}