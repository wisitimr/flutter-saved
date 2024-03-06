import 'package:equatable/equatable.dart';

class DaybookDetailFormModel extends Equatable {
  const DaybookDetailFormModel({
    required this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.account,
    required this.company,
  });

  final String id;
  final String name;
  final String type;
  final double amount;
  final String account;
  final String company;

  factory DaybookDetailFormModel.fromJson(Map<String, dynamic> json) =>
      DaybookDetailFormModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        amount: json['amount'] ?? '',
        account: json['account'] ?? '',
        company: json['company'] ?? '',
      );

  @override
  List<Object> get props => [
        id,
        name,
        type,
        amount,
        account,
        company,
      ];
}
