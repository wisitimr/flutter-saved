class DaybookDetail {
  final String id;
  final String name;
  final String type;
  final double amount;
  // final Account account;

  DaybookDetail({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    // required this.account,
  });

  factory DaybookDetail.fromJson(Map<String, dynamic> json) => DaybookDetail(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        amount: json['amount'],
        // account: Account.fromJson(json['account']),
      );
}
