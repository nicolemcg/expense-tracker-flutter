class ExpenseTransaction {
  int? id;
  String description;
  double amount;
  bool isIncome;
  String category;
  DateTime date;

  ExpenseTransaction({
    this.id,
    required this.description,
    required this.amount,
    required this.isIncome,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'isIncome': isIncome ? 1 : 0,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory ExpenseTransaction.fromMap(Map<String, dynamic> map){
    return ExpenseTransaction(
      id: map['id'],
      description: map['description'], 
      amount: map['amount'], 
      isIncome: map['isIncome'] == 1, 
      category: map['category'], 
      date: DateTime.parse(map['date']),
    );
  }
}