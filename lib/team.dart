import 'package:dto/transaction.dart';
import 'package:dto/user.dart';

class Team {
  final String title;
  final String? picturePath;
  final List<String>? tags;
  final DateTime startDate;
  final User owner;
  final List<User> users;
  final List<Transaction>? transactions;

  const Team(
      {required this.title,
      required this.owner,
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
      owner: User.fromJson(json['owner']),
      users: json['users'].map<User>((user) => User.fromJson(user)).toList(),
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
      'owner': 'users/${owner.email}',
      'users': users.map((user) => 'users/${user.email}').toList(),
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
