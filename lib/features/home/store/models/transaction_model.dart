class TransactionModel {
  final String name;
  final String amount;
  final String dateTime;
  final String balance;

  TransactionModel({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.balance,
  });
}

final transactionList = [
  TransactionModel(
    name: 'Refund',
    amount: '₹3200',
    balance: '₹18,110',
    dateTime: 'Today, 08:23 PM',
  ),
  TransactionModel(
    name: 'Coffee',
    amount: '-₹300',
    balance: '₹21,310',
    dateTime: 'Yesterday, 10:20 AM',
  ),
  TransactionModel(
    name: 'Coffee',
    amount: '-₹300',
    balance: '₹21,310',
    dateTime: 'Yesterday, 10:20 AM',
  ),
  TransactionModel(
    name: 'Transfer to Client',
    amount: '-₹50,000',
    balance: '₹21,610',
    dateTime: '10th Nov, 04:35 PM',
  ),
  TransactionModel(
    name: 'Transfer to Client',
    amount: '-₹50,000',
    balance: '₹21,610',
    dateTime: '10th Nov, 04:35 PM',
  ),
];
