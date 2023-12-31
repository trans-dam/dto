import 'package:dto/transaction.dart';

class Team {
  final String title;
  final String? picturePath;
  final List<String>? tags;
  final DateTime startDate;
  final List<String> users;
  final List<Transaction>? transactions;

  const Team(
      {required this.title,
      this.picturePath,
      this.tags,
      this.transactions,
      required this.startDate,
      required this.users});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      title: json['title'],
      picturePath: json['picturePath'],
      tags: json['tags'] == null ? [] : json['tags'].cast<String>(),
      startDate: json['startDate'].toDate(),
      users: json['users'] == null ? [] : json['users'].cast<String>(),
      transactions: json['transactions']
              ?.map<Transaction>(
                  (transaction) => Transaction.fromJson(transaction))
              .toList() ??
          [],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'picturePath': picturePath,
      'tags': tags != null ? tags!.toList() : [],
      'startDate': startDate,
      'users': users.map((user) => user).toList(),
      'transactions': transactions != null
          ? transactions?.map((transaction) => transaction.toJson()).toList()
          : [],
    };
  }

  getSum() {
    double sum = 0;
    if (transactions != null) {
      for (var transaction in transactions!) {
        sum += transaction.amount;
      }
    }
    return sum;
  }
}
