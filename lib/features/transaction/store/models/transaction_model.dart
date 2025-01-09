import '../../utilities/helper/formatter.dart';

class TransactionModel {
  final String id;
  final DateTime? date;
  final String? amount;
  final bool isExpense;
  final String? message;
  final List<String> tags;

  TransactionModel({
    this.date,
    this.amount,
    this.message,
    required this.id,
    required this.tags,
    required this.isExpense,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date?.toIso8601String(),
        'amount': int.parse(amount ?? '0'),
        'isExpense': isExpense,
        'message': message,
        'tags': tags.map((tag) => Format().tags(tag)),
      };

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id']?.toString() ?? '',
        date: json['date'] != null
            ? DateTime.parse(json['date'].toString())
            : null,
        amount: Format().amount(json['amount'] as int? ?? 0),
        isExpense: json['isExpense'] == true,
        message: json['message'] as String? ?? '',
        tags: (json['tags'] as List?)
                ?.map((tag) => Format().tags(tag.toString()))
                .toList() ??
            [],
      );
}

final transactionList = [
  TransactionModel(
    id: '',
    message: 'Refund ..........',
    amount: '₹3200',
    date: DateTime.now(),
    tags: ['pay'],
    isExpense: false,
  ),
  TransactionModel(
      id: '',
      message: 'Coffee',
      amount: '-₹300',
      date: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
      tags: ['food'],
      isExpense: true),
  TransactionModel(
    id: '',
    message: 'Transfer to Client',
    amount: '-₹50,000',
    date: DateTime(2024, 11, 10, 16, 35),
    tags: ['pay'],
    isExpense: true,
  ),
  TransactionModel(
      id: '',
      message: 'Transfer to Client',
      amount: '-₹50,000',
      date: DateTime(2024, 10, 18, 6, 5),
      tags: ['pay'],
      isExpense: true),
];
